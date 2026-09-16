source $HOME/.zshrc_function
source $HOME/.zshrc_filter
source $HOME/.zshrc_view
source $HOME/.zshrc_alias
source $HOME/.zshrc_general
source $HOME/.zshrc_tmux
source $HOME/.zshrc_secret
source $HOME/.zshrc_ai_agent

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

eval "$(mise activate zsh)"

export PATH="$HOME/.local/bin:$HOME/.local/share/mise/shims:$PATH"
export PATH="$(npm config get prefix)/bin:$PATH"

alias clauffe="caffeinate -i /Users/kenzo.tanaka/.claude/local/claude"

export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator"

# Android Studio 同梱 JBR を JAVA_HOME に設定 (gradlew 起動用)
export JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home"
export UV_DEFAULT_INDEX="https://token:$(sed -n 's|.*_authToken=||p' ~/.npmrc | head -1)@pypi.flatt.tech/simple/"
export COREPACK_NPM_REGISTRY=https://npm.flatt.tech
