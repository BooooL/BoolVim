#!/bin/sh 

BOOLVIM_PWD=$( pwd )

git clone git@github.com:tomasr/molokai.git
cp molokai/colors/molokai.vim .vim/color/

#remove the old vim 
apt-get remove vimsudo apt-get remove vim-runtime
apt-get remove vim-tiny
apt-get remove vim-common
apt-get remove vim-doc
apt-get remove vim-scrip

apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev libgtk2.0-dev
libatk1.0-dev libbonoboui2-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev
python-dev python3-dev ruby-dev  liblua5.1-dev libperl-dev git

#install vim 
git clone https://github.com/vim/vim.git
./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp=yes \
            --enable-pythoninterp=yes \
            --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
            --enable-python3interp=yes \
            --with-python3-config-dir=/usr/lib/python3.5/config-3.5m-x86_64_linux-gnu \
            --enable-perlinterp=yes \
            --enable-luainterp=yes \
            --enable-gui=gtk2 --enable-cscope --prefix=/usr

make VIMRUNTIMEDIR=/usr/share/vim/vim80 
make install 

# 下载 （在 `～/.vim/bundle` 目录下）
git clone --recursive git@github.com/Valloric/YouCompleteMe.git
# 检查完整性（在 `～/.vim/bundle/YouCompleteMe` 目录下）
git submodule update --init --recursive

apt-get install llvm-5.0 clang-5.0 libclang-5.0-dev  libboost-all-dev

cd $BOOLVIM_PWD 
mkdir .ycm_build
cd .ycm_build
cmake -G "Unix Makefiles" -DUSE_SYSTEM_BOOST=ON -DUSE_SYSTEM_LIBCLANG=ON . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
cmake -G "Unix Makefiles" -DUSE_SYSTEM_BOOST=ON -DEXTERNAL_LIBCLANG_PATH=/usr/lib/x86_64-linux-gnu/libclang-5.0.so . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
cmake --build . --target ycm_core --config Release

cp ~/.vim/bundle/YouCompleteMe/third_party/ycmd/examples/.ycm_extra_conf.py ~/.vim/

