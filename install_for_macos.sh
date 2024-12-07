#!/bin/sh

shell_path=$(cd $(dirname $0);pwd)

# zsh
for filename in `ls -A ./zsh/`
do
  ln -fs ${shell_path}/zsh/${filename} ~/
done

# tmux
ln -fs ${shell_path}/.tmux.conf ~/
ln -fs ${shell_path}/getwifi.sh ~/
ln -fs ${shell_path}/clear_github_profile_status.sh ~/

# git
for filename in `ls -A ./git/`
do
  ln -fs ${shell_path}/git/${filename} ~/
done

# vim
ln -fs ${shell_path}/vim/.vimrc ~/

# vscode
ln -fs ${shell_path}/vscode/settings.json ~/Library/Application\ Support/Code/User/

# gpg
ln -fs ${shell_path}/gpg/gpg-agent.conf ~/.gnupg/
