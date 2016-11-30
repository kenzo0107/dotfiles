# dotfiles
dotfile setting

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
$ mkdir -p ~/.vim/bundle
$ git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
```

### Install

You see vim window, so execute the below command:

```
:NeoBundleInstall
```

![Imgur](http://i.imgur.com/FGwN3Ea.png)

At the case of Update:

```
:NeoBundleUpdate
```

- Updating

![Imgur](http://i.imgur.com/LOZbz3s.png)

- Complete

![Imgur](http://i.imgur.com/xU6rPnB.png)