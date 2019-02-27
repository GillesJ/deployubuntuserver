# Created by gilles

# set termtitle to pwd
case $TERM in
  xterm*)
    precmd () {print -Pn "\e]0;%~\a"}
    ;;
esac

# ZPLUG zsh plugin manager
source ~/.zplug/init.zsh

# let zplug manage itself
zplug "zplug/zplug"

# plugins
zplug "jamesob/desk", as:command, use:"desk"
zplug "raylee/tldr", as:command, use:"tldr"
zplug "rimraf/k"
zplug "djui/alias-tips"
zplug "b4b4r07/enhancd", use:init.sh
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
# zplug "psprint/zsh-morpho"
zplug "robertzk/send.zsh"
zplug "zdharma/zsh-diff-so-fancy", as:command, use:bin/git-dsf

# Support oh-my-zsh plugins and the like
zplug "plugins/git", from:oh-my-zsh

# zsh themes
zplug "mafredri/zsh-async", from:github, defer:0  # Load this first

#zplug "therealklanni/purity", use:purity.zsh, from:github, as:theme
zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme
#zplug "themes/robbyrussell", from:oh-my-zsh
#zplug "dracula/zsh", as:theme

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

# aliases
## package mgmt aliases
alias aptupgrade="sudo apt-get update; sudo apt-get -u upgrade; sudo apt-get dist-upgrade; sudo apt-get autoclean; sudo apt-get autoremove"
alias pipupgradeall="pip install --upgrade pip; pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U"
alias everythingupgrade="aptupgrade; sudo snap refresh; pipupgradeall; zplug update"

## file handling and other aliases
alias k="k -h"
alias ping="prettyping"
alias du="ncdu --color dark -rr -x"
alias fixnemo="killall nemo && killall gvfsd-sftp"
alias startlogkeys='sudo logkeys -s -m ~/repos/logkeys/keymaps/en_US_ubuntu_1204.map -o ~/.strokes.log'
alias instascrape="sh ~/data/instagramscrape/scrapecommand.sh"
alias trelloweeklyoverview="python ~/repos/trelloweeklyoverview/makeoverview.py"
alias adbsyncphonemusic="adb-sync ~/Music_phone/ /sdcard/Music/"
alias rsynclazy="sudo rsync -hrlDvzP --size-only --no-perms --no-owner --no-group --omit-dir-times"
alias scrapesoundcloudlikes="cd ~/Music/soundcloud && soundscrape -fl gatling; cd -"
## vpn aliases
alias ugent-reconnect="sudo vpnc-disconnect; sudo vpnc-connect ugent"
alias ugent-connect="sudo vpnc-connect ugent"
alias openvpn-zurich="sudo openvpn --auth-nocache --daemon --config ~/sysmgmt/vpn/CH\ -\ Zurich\ @tigervpn.com.ovpn && echo 'Started VPN! Getting public ip:' && whatpublicip"
alias openvpn-la="sudo openvpn --auth-nocache --daemon --config 'US - Los Angeles @tigervpn.com.ovpn' && echo 'Started VPN! Getting public ip:' && whatpublicip"
alias openvpn-kill="sudo killall openvpn && sudo ip link delete tun0"
alias whatpublicip="curl --progress-bar 'http://api.ipstack.com/check?access_key=69ccae26048dfa1170daa778ce3e0258&fields=ip,country_name,region_name,city,zip,continent_name,hostname&hostname=1' | jq"

# Hook for desk activation
[ -n "$DESK_ENV" ] && source "$DESK_ENV" || true

#cuda library path
PATH=/home/gilles/.local/bin:/usr/local/cuda-8.0/bin${PATH:+:${PATH}}; export PATH
LD_LIBRARY_PATH=/usr/local/cuda-8.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}; export LD_LIBRARY_PATH

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
