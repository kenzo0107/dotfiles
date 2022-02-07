# dotfiles


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

- First of all, execute the bellowing command for MacOSX.

```
$ brew install reattach-to-user-namespace

// set battery-display in header status bar.
$ brew tap Goles/battery
$ brew install battery
```

- Linux (centos)

```
$ yum install -y tmux
```

## vim

- download .vimrc

```
$ curl 'http://vim-bootstrap.com/generate.vim' --data 'langs=go&langs=ruby&langs=php&langs=html&langs=javascript&editor=vim' > ~/dotfiles/.vimrc
```

- Plugin Install

When you try to open vim command, installation of vim-plugin will start.

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

- copy to clipboard in vim
	* vim version >= 7.4
	* `+clipboard` required. `vim --version | grep clipboard`

```
$ echo 'set clipboard+=unnamed' >> ~/.vimrc
```

```
$ vim --version | grep clipboard

+clipboard       +job             +path_extra      +user_commands
+eval            +mouse_dec       +statusline      -xterm_clipboard
```

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

