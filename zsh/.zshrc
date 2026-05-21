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

# Google Cloud credentials for Claude Code MCP
export GOOGLE_APPLICATION_CREDENTIALS=~/.gcp/claude-gcp-key.json
export GOOGLE_CLOUD_PROJECT=mext-redash-tool-production
export PATH="$HOME/.local/share/mise/shims:$PATH"
export PATH="$(npm config get prefix)/bin:$PATH"
