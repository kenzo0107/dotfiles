#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: clean-worktrees.sh [--apply] [--delete-branch] [NAME...]

メイン以外の git worktree について削除してよいかを判定し、表にして出す。既定は dry-run。

  --apply          OK と判定した worktree を削除する
  --delete-branch  削除した worktree のブランチを git branch -d で消す（未マージなら残す）
  NAME             対象を絞る（worktree の絶対パス、またはディレクトリ名）

判定（1つでも当てはまれば NG で、削除しない）:
  - 現在のディレクトリがその worktree の中にある
  - ロック中で、ロックしたプロセスがまだ動いている（理由に pid がないロックも NG）
  - 未コミットの変更か未追跡ファイルがある（.gitignore 対象は見ない）
  - どのリモートにもないコミットがあり、そのブランチの PR もマージされていない
EOF
}

apply=false
delete_branch=false
filters=()
while [ $# -gt 0 ]; do
  case "$1" in
    --apply) apply=true ;;
    --delete-branch) delete_branch=true ;;
    -h | --help) usage; exit 0 ;;
    -*) echo "unknown option: $1" >&2; usage >&2; exit 2 ;;
    *) filters+=("$1") ;;
  esac
  shift
done

git rev-parse --show-toplevel >/dev/null
# 古いリモート参照のままだと、push 済みのコミットを「未 push」と誤判定するため
git fetch --all --prune --quiet

matches_filter() {
  local path="$1" f
  [ ${#filters[@]} -eq 0 ] && return 0
  for f in "${filters[@]}"; do
    [ "$f" = "$path" ] || [ "$f" = "$(basename "$path")" ] && return 0
  done
  return 1
}

# 空欄のままだと IFS=$'\t' の read が連続タブを1つにまとめて列がずれるため、"-" で埋める
list_worktrees() {
  git worktree list --porcelain | awk '
    function emit() { if (p != "") print p "\t" (b == "" ? "-" : b) "\t" l "\t" (r == "" ? "-" : r) }
    /^worktree / { emit(); p = substr($0, 10); b = ""; l = 0; r = "" }
    /^branch /   { b = substr($0, 8); sub("^refs/heads/", "", b) }
    /^detached/  { b = "(detached)" }
    /^locked/    { l = 1; r = substr($0, 8) }
    END          { emit() }
  ' | tail -n +2
}

judge() {
  local path="$1" branch="$2" locked="$3" reason="$4"

  if [ ! -d "$path" ]; then
    printf 'OK\tディレクトリなし（prune 対象）'
    return
  fi

  case "$(pwd -P)/" in
    "$(cd "$path" && pwd -P)/"*)
      printf 'NG\t現在のディレクトリ'
      return
      ;;
  esac

  if [ "$locked" = 1 ]; then
    local pid started actual
    pid=$(printf '%s' "$reason" | sed -n 's/.*pid \([0-9][0-9]*\).*/\1/p')
    if [ -z "$pid" ]; then
      printf 'NG\tロック中: %s' "$reason"
      return
    fi
    if ps -p "$pid" >/dev/null 2>&1; then
      started=$(printf '%s' "$reason" | sed -n 's/.*start \(.*\))$/\1/p' | tr -s ' ')
      actual=$(ps -o lstart= -p "$pid" | tr -s ' ' | sed 's/^ //')
      # pid は再利用されるので、開始時刻まで一致したときだけ使用中とみなす
      if [ -z "$started" ] || [ "$started" = "$actual" ]; then
        printf 'NG\tロックしたプロセスが稼働中 (pid %s)' "$pid"
        return
      fi
    fi
  fi

  local dirty
  dirty=$(git -C "$path" status --porcelain --untracked-files=all | wc -l | tr -d ' ')
  if [ "$dirty" -gt 0 ]; then
    printf 'NG\t未コミットの変更・未追跡ファイル %s 件' "$dirty"
    return
  fi

  local unpushed
  unpushed=$(git -C "$path" rev-list --count HEAD --not --remotes)
  if [ "$unpushed" -gt 0 ]; then
    # rev-list だけで NG にしないのは、squash マージ済みのブランチでもコミットがリモートに残らないため
    if [ "$branch" = "(detached)" ] || ! command -v gh >/dev/null; then
      printf 'NG\tリモートにないコミット %s 件' "$unpushed"
      return
    fi
    local merged
    if ! merged=$(cd "$path" && gh pr list --head "$branch" --state merged --json number --jq length 2>/dev/null); then
      printf 'NG\tリモートにないコミット %s 件（gh で PR を確認できない）' "$unpushed"
      return
    fi
    if [ "$merged" -eq 0 ]; then
      printf 'NG\tリモートにないコミット %s 件（マージ済み PR なし）' "$unpushed"
      return
    fi
    printf 'OK\tPR マージ済み'
    return
  fi

  if [ "$locked" = 1 ]; then
    printf 'OK\t変更なし・push 済み（ロックしたプロセスは終了済み）'
  else
    printf 'OK\t変更なし・push 済み'
  fi
}

ok=0
ng=0
removed=0
printf '%s\t%s\t%s\t%s\n' 判定 worktree ブランチ 理由
while IFS=$'\t' read -r path branch locked reason; do
  matches_filter "$path" || continue
  [ "$reason" = "-" ] && reason=""

  result=$(judge "$path" "$branch" "$locked" "$reason")
  status=${result%%$'\t'*}
  printf '%s\t%s\t%s\t%s\n' "$status" "$path" "$branch" "${result#*$'\t'}"

  if [ "$status" = NG ]; then
    ng=$((ng + 1))
    continue
  fi
  ok=$((ok + 1))
  $apply || continue

  if [ -d "$path" ]; then
    if [ "$locked" = 1 ]; then
      git worktree remove -f -f "$path"
    else
      git worktree remove "$path"
    fi
  fi
  removed=$((removed + 1))

  if $delete_branch && [ "$branch" != "(detached)" ]; then
    git branch -d "$branch" >/dev/null 2>&1 \
      || echo "  ブランチ $branch は未マージ扱いのため残しました（消すなら git branch -D）" >&2
  fi
done < <(list_worktrees)

$apply && git worktree prune

echo
if $apply; then
  echo "削除 ${removed} 件 / 対象外 (NG) ${ng} 件"
else
  echo "削除可 (OK) ${ok} 件 / 対象外 (NG) ${ng} 件（dry-run。削除するには --apply）"
fi
