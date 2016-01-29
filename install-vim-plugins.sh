mkdir ~/.vim/bundle
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

#install vim bundles
vim -c 'PluginInstall' -c 'qa'

#install latest version of netrw and source it
tmpFile=/tmp/netrw.vba.gz && wget -qO $tmpFile http://www.vim.org/scripts/download_script.php?src_id=21427 && vim -S $tmpFile -c 'q'
