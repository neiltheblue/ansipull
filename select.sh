#!/bin/bash 

DIR=$(dirname $0)

if [ -z "$1" ]
then
  ls $DIR/system/roles 
else
  ansible-playbook $DIR/system/select.yml -K -e play_role=$1
fi
