# ------------------------------
# import settings
# ------------------------------

source $HOME/.zshrc_function
source $HOME/.zshrc_peco
source $HOME/.zshrc_view
source $HOME/.zshrc_alias
source $HOME/.zshrc_export
source $HOME/.zshrc_general
source $HOME/.zshrc_tmux

source $HOME/.zshrc_local

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/kenzo/.sdkman"
[[ -s "/Users/kenzo/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/kenzo/.sdkman/bin/sdkman-init.sh"
