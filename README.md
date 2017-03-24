# dotfiles

## dotfile setting

```
$ cd ~
$ git clone https://github.com/kenzo0107/dotfiles
$ sh dotfiles/symlink.sh
```

---

## zsh

- `.zshrc_local` - It will be available in the private.
- Other files - Its names are divided by applications.


※ The files For buisiness are named as `.zshrc_(company_name)`

---

## tmux

- First of all, execute the bellowing command for MacOSX.

```
$ brew install reattach-to-user-namespace
```

- Linux (centos)

```
$ yum install -y tmux
```

## vim

### download NeoBundle

```
$ curl 'http://vim-bootstrap.com/generate.vim' --data 'langs=go&langs=ruby&langs=php&langs=html&langs=javascript&editor=vim' > ~/dotfiles/.vimrc
```

## Plugin Install 

When you try to open vim command, installation of vim-plugin will start.


```
$ vim

Installing Vim-Plug...
```

### vim bootstrap update

opening vim, input the below command.

```
:VimBootstrapUpdate
```
