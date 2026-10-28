---
name: clean-worktrees
description: メイン以外の git worktree を、未コミットの変更・未 push のコミット・稼働中セッションのロックがないことを確かめてから削除する。「worktree を削除して」「worktree を掃除して」「不要な worktree を片付けて」で使う。Claude セッションのロックが残った worktree も、ロックしたプロセスが終了していれば消せる。
---

# worktree の削除（clean-worktrees）

判定と削除は `scripts/clean-worktrees.sh` が行う。手で `git worktree remove -f -f` を打たない。

## 背景（失敗分析）

- `.claude/worktrees/` に作られた worktree は Claude セッションのロック（`locked claude session ... (pid N start ...)`）が付いたまま残る。プロセスが終わっていても、`-f -f` を付けないと消せない。
- ロックを無視して消すと、別のセッションが作業中の worktree を消すおそれがある。そのため、pid と開始時刻でプロセスの生存を確かめる。
- リモートブランチが `[gone]` でも、マージされたとは限らない。squash マージならコミットがリモートに残らないので、`gh` でマージ済み PR があるかを確かめる。

## 手順

1. 対象のリポジトリで dry-run し、判定表をユーザーに見せる。

   ```bash
   ~/.claude/skills/clean-worktrees/scripts/clean-worktrees.sh [NAME...]
   ```

2. 削除する。
   - ユーザーがすでに削除を依頼していれば、OK の worktree は確認なしで削除してよい。
   - ブランチも消すかどうかは、ユーザーが求めたときだけ `--delete-branch` を付ける。

   ```bash
   ~/.claude/skills/clean-worktrees/scripts/clean-worktrees.sh --apply [--delete-branch] [NAME...]
   ```

3. NG の worktree は消さない。理由（未コミットの変更、稼働中のセッションなど）をユーザーに伝えて判断を仰ぐ。強制削除の指示があっても、変更が失われることを先に伝える。

## 検証

- `git worktree list` で、OK の worktree が消え、NG の worktree が残っていることを確かめてから報告する。
- スクリプトが非 0 で終了したら、出力をそのまま報告する（`git fetch` の失敗を含む）。成功扱いにしない。
