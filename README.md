# Deploy new Ubuntu server
This repo contains the main deployment script for setting up my personal tooling on a fresh Ubuntu host.

## Requirements:
* Ubuntu (Server) 14.04+ on an amd64 system w/ apt-get and sh
* root permission (sudoer) on user

## Usage
Copy this repo to $HOME, go to $HOST and run script:
'''
rsync -HavrPz . $USER@$HOST:/$HOME
ssh $USER@$HOST
cd deployubuntuserver.sh
./deployubuntuserver.sh
'''

## Installs and configures
* ZSH shell
** zplug: zsh pluging manager, themes, etc.
** desk: manage working envs
** k: ls but nicer
** fzf: improved fuzzy search
** diff-so-fancy: fancy-pants diff

* bat: blazing fast cat with syntax highlighting and git support
* cf. aptpackages.txt snappackages.txt

## Troubleshooting
* My delete/homecluster+fn keys missbehave and output ~ tildes!
Bash iterprets keyboard inputs with definitions in /etc/.
ZSH does not use this, sometimes it works on a machine, sometimes it doesn't ¯\_(ツ)_/¯,.
http://zshwiki.org/home/zle/bindkeys for a proper solution.
If all else fails: append the following bindkey definitions to your .zshrc:
```
# key bindings
bindkey "e[1~" beginning-of-line
bindkey "e[4~" end-of-line
bindkey "e[5~" beginning-of-history
bindkey "e[6~" end-of-history
bindkey "e[3~" delete-char
bindkey "e[2~" quoted-insert
bindkey "e[5C" forward-word
bindkey "eOc" emacs-forward-word
bindkey "e[5D" backward-word
bindkey "eOd" emacs-backward-word
bindkey "ee[C" forward-word
bindkey "ee[D" backward-word
bindkey "^H" backward-delete-word
# for rxvt
bindkey "e[8~" end-of-line
bindkey "e[7~" beginning-of-line
# for non RH/Debian xterm, can't hurt for RH/DEbian xterm
bindkey "eOH" beginning-of-line
bindkey "eOF" end-of-line
# for freebsd console
bindkey "e[H" beginning-of-line
bindkey "e[F" end-of-line
# completion in the middle of a line
bindkey '^i' expand-or-complete-prefix
```