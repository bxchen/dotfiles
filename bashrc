# Sample .bashrc for SuSE Linux
# Copyright (c) SuSE GmbH Nuernberg

# There are 3 different types of shells in bash: the login shell, normal shell
# and interactive shell. Login shells read ~/.profile and interactive shells
# read ~/.bashrc; in our setup, /etc/profile sources ~/.bashrc - thus all
# settings made here will also take effect in a login shell.
#
# NOTE: It is recommended to make language settings in ~/.profile rather than
# here, since multilingual X sessions would not work properly if LANG is over-
# ridden in every subshell.

# Some applications read the EDITOR variable to determine your favourite text
# editor. So uncomment the line below and enter the editor of your choice :-)
#export EDITOR=/usr/bin/vim
#export EDITOR=/usr/bin/mcedit

# For some news readers it makes sense to specify the NEWSSERVER variable here
#export NEWSSERVER=your.news.server

# If you want to use a Palm device with Linux, uncomment the two lines below.
# For some (older) Palm Pilots, you might need to set a lower baud rate
# e.g. 57600 or 38400; lowest is 9600 (very slow!)
#
#export PILOTPORT=/dev/pilot
#export PILOTRATE=115200

test -s ~/.alias && . ~/.alias || true
export PATH=$PATH:/sbin:/usr/local/sbin:/home/bxchen/.local/bin:/usr/local/texlive/2013/bin/x86_64-linux
export INFOPATH=$INFOPATH:/usr/local/texlive/2013/texmf-dist/doc/info
export MANPATH=$MANPATH:/usr/local/texlive/2013/texmf-dist/doc/man
#. /usr/local/itt/idl82/bin/idl_setup.bash
alias rdesktop_spem='rdesktop -u imglab -p imglab 205.208.91.164 -g 1920x1150'
alias siraf='ssh -Y bxchen@siraf-login'
alias titanomachy='ssh -Y bxchen@titanomachy'
alias nether='ssh -Y bxchen@nether'
alias hercules='ssh -Y bxchen@hercules'
alias workhorse='ssh -Y bxchen@workhorse'
alias midway='ssh -Y bxchen@midway.rcc.uchicago.edu'
