PATH=/opt/python-2.7/bin:$PATH

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# git
alias gs='git status'
alias gb='git branch'
alias gba='git branch -a'
alias gpsh='git push'
alias gpll='git pull'
alias gtoplevel='git rev-parse --show-toplevel'

alias ll='ls -al'

autoload colors
colors

PROMPT="
 %{${fg[yellow]}%}%~%{${reset_color}%} 
[%F{green}%n%f@%F{white}%U%m%u%f]$ "
PROMPT2='[%n]> '

# 補完関係
autoload -U compinit; compinit # 補完機能を有効にする
setopt auto_list               # 補完候補を一覧で表示する(d)
setopt auto_menu               # 補完キー連打で補完候補を順に表示する(d)
setopt list_packed             # 補完候補をできるだけ詰めて表示する
setopt list_types              # 補完候補にファイルの種類も表示する
bindkey "^[[Z" reverse-menu-complete  # Shift-Tabで補完候補を逆順する("\e[Z"でも動作する)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完時に大文字小文字を区別しない

 
# Color
# 色の設定
export LSCOLORS=gxfxcxdxbxegedabagacad

# 補完時の色の設定
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# ZLS_COLORSとは？
export ZLS_COLORS=$LS_COLORS
# lsコマンド時、自動で色がつく(ls -Gのようなもの？)
export CLICOLOR=true
# 補完候補に色を付ける
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}


# vcs_info
autoload vcs_info
# gitのみ有効にする
zstyle ":vcs_info:*" enable git
# commitしていない変更をチェックする
zstyle ":vcs_info:git:*" check-for-changes true

# gitリポジトリに対して、変更情報とリポジトリ情報を表示する
#zstyle ":vcs_info:git:*" formats "%c%u[%b:%r]"
zstyle ":vcs_info:git:*" formats "%c%u"

# gitリポジトリに対して、コンフリクトなどの情報を表示する
#zstyle ":vcs_info:git:*" actionformats "%c%u<%a>[%b:%r]"
zstyle ":vcs_info:git:*" actionformats "%c%u<%a>"

# addしていない変更があることを示す文字列
zstyle ":vcs_info:git:*" unstagedstr "%F{196}[Add!(>_<)]%f"
# commitしていないstageがあることを示す文字列
zstyle ":vcs_info:git:*" stagedstr "%F{166}[STAGING(*'i')>]%f"

# git：まだpushしていないcommitあるかチェックする
my_git_info_push () {
	if [ "$(git remote 2>/dev/null)" != "" ]; then
#		local head="$(git rev-parse HEAD)"
		local remote
		for remote in $(git rev-parse --remotes) ; do
			if [ "$head" = "$remote" ]; then return 0 ; fi
		done
		# pushしていないcommitがあることを示す文字列
		echo "%F{196}[☀︎ ]%f"
	fi
}

# git：stashに退避したものがあるかチェックする
my_git_info_stash () {
	if [ "$(git stash list 2>/dev/null)" != "" ]; then
		# stashがあることを示す文字列
		echo "{s}"
	fi
}

# vcs_infoの出力に独自の出力を付加する
my_vcs_info () {
	vcs_info
	echo $(my_git_info_stash)$(my_git_info_push)$vcs_info_msg_0_
}

# プロンプト定義の中で置換を使用する
setopt prompt_subst

# プロンプト定義
RPROMPT=$'$(my_vcs_info)'


