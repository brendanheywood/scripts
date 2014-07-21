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


