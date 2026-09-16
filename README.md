# dotfiles

## brew

http://brew.sh/

```console
sh brew.sh
```

## asdf

https://github.com/asdf-vm/asdf

```console
$ sh asdf.sh
```

## vscode

https://code.visualstudio.com/

install extensions

```
$ sh vscode/install_extensions.sh
```

## dotfile setting

```
$ sh install_for_macos.sh
```

## restart shell

```
$ exec $SHELL -l
```

---

## zsh

- `.zshrc_local` - It will be available in the private.
- Other files - Its names are divided by applications.

※ The files For buisiness are named as `.zshrc_(company_name)`

## tmux

https://github.com/tmux/tmux/wiki

- First of all, execute the bellowing command for MacOSX.

```
$ brew install reattach-to-user-namespace
```

## bin

`bin/` 配下のスクリプトは `install_for_macos.sh` で `~/.local/bin/` にシンボリックリンクされる。

- `open-prs [owner]` - 自分が作成したオープン中の PR を一覧表示する（対象ユーザーは `gh` のログインアカウント。`OPEN_PRS_AUTHOR` で上書き可）

## vim

- Plugin Install
  - When you try to open vim command, installation of vim-plugin will start.

```
$ vim

Installing Vim-Plug...
```

- vim bootstrap update

opening vim, input the below command.

```
:VimBootstrapUpdate
:PlugInstall
```
