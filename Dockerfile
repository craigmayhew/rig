############################################################
# Dockerfile to run Craigs Workstation
# Based on Ubuntu Image
#
# Useful commands:
#   docker build -t cmdock -f Dockerfile .
#   docker run -i -t cmdock
#   docker run -i -t -v /home/user craigmayhew/ws /bin/bash
# 
############################################################

# Set the base image to use to Ubuntu
FROM ubuntu:16.04

MAINTAINER Craig Mayhew

# run this to prevent the language question breaking apt-get further down this list of commands
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Update the default application repository sources list
RUN apt-get --assume-yes update

# Install / remove packages
RUN apt-get --assume-yes remove aisleriot brasero gnome-mines gnome-sudoku gnomine rhythmbox-plugin-zeitgeist rhythmbox rhythmbox-plugin-cdrecorder rhythmbox-mozilla rhythmbox-plugins shotwell shotwell-common simple-scan

RUN apt-get --assume-yes update

# useful if we want to add software repos to apt
RUN apt-get --assume-yes install software-properties-common

RUN apt-get --assume-yes install docker.io git openssh-server php5-cli php5-curl putty-tools vim

# lose unitf gnome and add xmbc
RUN apt-get --assume-yes install xubuntu-desktop gksu leafpad synaptic
RUN apt-get --assume-yes remove gimp gmusicbrowser gnome-power-manager gnome-screensaver gnome-termina* gnome-pane* gnome-applet* gnome-bluetooth gnome-desktop* gnome-mahjongg gnome-sessio* gnome-user* gnome-shell-common compiz compiz* unity unity* hud zeitgeist zeitgeist* python-zeitgeist libzeitgeist* activity-log-manager-common gnome-control-center gnome-screenshot nautilus overlay-scrollba* rhythmbox
RUN apt-get --assume-yes install xubuntu-community-wallpapers
RUN apt-get --assume-yes autoremove

# install openvpn
RUN apt-get --assume-yes install openvpn

# install command line text based browser
RUN apt-get --assume-yes install links

# install meld for comparing files in a gui
RUN apt-get --assume-yes install meld

# install curl
RUN apt-get --assume-yes install curl

# install vim as we need it to make vi use pathogen etc
RUN apt-get --assume-yes install vim

# cleanup
RUN apt-get --assume-yes autoremove

# download and install mysql workbench
RUN wget https://dev.mysql.com/get/Downloads/MySQLGUITools/mysql-workbench-community-6.3.6-1ubu1510-amd64.deb && apt-get --assume-yes install ./mysql-workbench-community-6.3.6-1ubu1510-amd64.deb && rm ./mysql-workbench-community-6.3.6-1ubu1510-amd64.deb

# create user user
RUN useradd -m user -s /bin/bash 

# set terminal colours
RUN setterm --term linux --back black --fore white --clear all

# download dot files from github
RUN cd ~/ && git clone https://github.com/craigmayhew/dotfiles.git && rsync -a dotfiles/ ~/ && rm -rf ~/dotfiles

# download repos from github that I maintain
RUN mkdir -p ~/gitrepos/mine && cd ~/gitrepos/mine && git clone https://github.com/craigmayhew/craig.mayhew.io.git
RUN mkdir -p ~/gitrepos/mine && cd ~/gitrepos/mine && git clone https://github.com/craigmayhew/rig.git
RUN mkdir -p ~/gitrepos/mine && cd ~/gitrepos/mine && git clone https://github.com/craigmayhew/scratchpad.git

# install arc for phabricator
RUN mkdir -p ~/gitrepos/others && cd ~/gitrepos/others && git clone https://github.com/phacility/libphutil.git && git clone https://github.com/phacility/arcanist.git && export PATH="$PATH:/home/craig/gitrepos/others/arcanist/bin"

# make the pretty git lg command available
RUN git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue) %an%Creset' --abbrev-commit"
# undo the last git commit
RUN git config --global alias.undocommit "reset --soft HEAD~1"
# show the last commit as a diff
RUN git config --global alias.last "diff HEAD~1 HEAD"

# set git global options
RUN git config --global color.diff auto
RUN git config --global color.status auto
RUN git config --global color.branch auto
RUN git config --global color.interactive auto
RUN git config --global color.ui auto
RUN git config --global gc.auto 1
RUN git config --global push.default simple
RUN git config --global branch.autosetuprebase always

#install hack font
RUN mkdir -p ~/.fonts/ && cd ~/.fonts/ && wget https://github.com/chrissimpkins/Hack/raw/master/build/ttf/Hack-Bold.ttf && wget https://github.com/chrissimpkins/Hack/raw/master/build/ttf/Hack-BoldItalic.ttf && wget https://github.com/chrissimpkins/Hack/raw/master/build/ttf/Hack-Italic.ttf && wget https://github.com/chrissimpkins/Hack/raw/master/build/ttf/Hack-Regular.ttf

# Port to expose (default: 11211)
EXPOSE 11211
