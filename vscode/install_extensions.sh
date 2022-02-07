#!/bin/sh

if [ ! -e "$(which code)" ]; then
  echo "you should install vscode. ex: brew install visual-studio-code --cask"
  exit 1
fi

shell_path=$(cd $(dirname $0);pwd)

cat ${shell_path}/extensions | while read ex
do
  code --install-extension $ex
done
