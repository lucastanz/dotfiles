mkdir ~/.vim/bundle
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

#install vim bundles
vim -c 'PluginInstall' -c 'qa'

#install latest version of netrw and source it
tmpFile=/tmp/netrw.vba.gz && wget -qO $tmpFile http://www.vim.org/scripts/download_script.php?src_id=21427 && vim -S $tmpFile -c 'q'

#install php-cs-fixer if not present
if ! which php-cs-fixer; then 
    wget http://get.sensiolabs.org/php-cs-fixer-v1.11.phar -O php-cs-fixer
    sudo chmod a+x php-cs-fixer
    sudo mv php-cs-fixer /usr/local/bin/php-cs-fixer
fi

#install molokai theme
if [ ! -d ~/.vim/colors ]; then
    mkdir ~/.vim/colors
fi

wget -O ~/.vim/colors/molokai.vim https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim
