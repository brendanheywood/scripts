#!/bin/sh -e

# Install .bashrc
if grep 'scripts/.bashrc' ~/.bashrc
then
  echo '[ok] .bashrc'
else
  # Append rather than replace
  echo '. ~/scripts/.bashrc' >> ~/.bashrc
  echo 'Appended to .bashrc'
  . ~/.bashrc
fi

# Sym link .vim dir
if [ -L ~/.vim ]; then
  echo "[ok] .vim"
elif [ -e ~/.vim ]; then
  echo "[bad] .vim exists!"
else
  ln -s ~/scripts/.vim ~/.vim
  echo "[ok] Created .vim/ sym link"
fi

# Sym link .vimrc
if [ -L ~/.vimrc ]; then
  echo "[ok] .vimrc"
elif [ -e ~/.vimrc ]; then
  echo "[bad] .vimrc exists!"
else
  ln -s ~/scripts/.vimrc ~/.vimrc
  echo "[ok] Created .vimrc sym link"
fi

# Sym link .gitconfig
if [ -L ~/.gitconfig ]; then
  echo "[ok] .gitconfig"
elif [ -e ~/.gitconfig ]; then
  echo "[bad] .gitconfig exists!"
else
  ln -s ~/scripts/.gitconfig ~/.gitconfig
  echo "[ok] Created ~/.gitconfig sym link"
fi


# Sym link .psqlrc
if [ -L ~/.psqlrc ]; then
  echo "[ok] .psqlrc"
elif [ -e ~/.psqlrc ]; then
  echo "[bad] .psqlrc exists!"
else
  ln -s ~/scripts/.psqlrc ~/.psqlrc
  echo "[ok] Created ~/.psqlrc sym link"
fi


