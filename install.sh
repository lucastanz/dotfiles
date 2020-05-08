################################################################################
# update and install packages
#
sudo apt-get update
sudo apt-get -y install tmux

################################################################################
# install vim bundles
#
vim -c 'PlugInstall' -c 'qa'

################################################################################
# install latest version of netrw and source it
#
tmpFile=/tmp/netrw.vba.gz && wget -qO $tmpFile http://www.vim.org/scripts/download_script.php?src_id=21427 && vim -S $tmpFile -c 'q'

################################################################################
# molokai theme
#
if [ ! -d ~/.vim/colors ]; then
    mkdir ~/.vim/colors
fi

wget -O ~/.vim/colors/molokai.vim https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim

################################################################################
# install universal ctags
#
git clone https://github.com/universal-ctags/ctags.git /tmp/ctags && cd $_
sudo apt-get install dh-autoreconf
./autogen.sh
./configure
make
sudo make install

################################################################################
# install fzf
#
if ! which fzf; then 
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install
fi

################################################################################
# install ripgrep (Debian) - https://github.com/BurntSushi/ripgrep#installation
#
https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
sudo dpkg -i ripgrep_11.0.2_amd64.deb

################################################################################
# tmux
#
mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

################################################################################
# phpstan for vim ale
#
composer global req phpstan/phpstan
