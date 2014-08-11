#!/bin/sh

# Install .bashrc
if grep 'scripts/.bashrc' ~/.bashrc
then
  echo '[ok] Bashrc'
else
  echo 'Setting up .bashrc'
  echo '. ~/scripts/.bashrc' >> ~/.bashrc
  . ~/.bashrc
fi

# Sym link .vim dir
if [ -L ~/.vim ]; then
  # It is a symlink!
  # Symbolic link specific commands go here.
  echo "[ok] .vim $LINK_OR_DIR"
elif [ -d ~/.vim ]; then 
  # It's a directory!
  # Directory command goes here.
  echo "[bad] .vim dir exists!"
else
  ln -s ~/scripts/.vim ~/.vim
  echo "[ok] Created ~/.vim/ sym link"
fi

# Sym link .vimrc
if [ -L ~/.vimrc ]; then
  # It is a symlink!
  # Symbolic link specific commands go here.
  echo "[ok] .vimrc $LINK_OR_DIR"
elif [ -e ~/.vimrc ]; then 
  # It's a directory!
  # Directory command goes here.
  echo "[bad] .vimrc exists!"
else
  ln -s ~/scripts/.vimrc ~/.vimrc
  echo "[ok] Created ~/.vimrc sym link"
fi


