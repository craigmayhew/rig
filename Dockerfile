############################################################
# Dockerfile to run Craigs Workstation
# Based on Ubuntu Image
############################################################

# Set the base image to use to Ubuntu
FROM ubuntu:16.04

MAINTAINER Craig Mayhew

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Update the default application repository sources list
RUN apt-get --assume-yes update

# Install / remove packages
RUN apt-get --assume-yes remove aisleriot brasero gnome-mines gnome-sudoku gnomine rhythmbox-plugin-zeitgeist rhythmbox rhythmbox-plugin-cdrecorder rhythmbox-mozilla rhythmbox-plugins shotwell shotwell-common simple-scan

RUN apt-get --assume-yes update

# useful if we want to add software repos to apt
RUN apt-get --assume-yes install software-properties-common

RUN apt-get --assume-yes install docker.io git openssh-server php5-cli php5-curl putty-tools vim

#lose unitf gnome and add xmbc
RUN apt-get --assume-yes install xubuntu-desktop gksu leafpad synaptic
RUN apt-get --assume-yes remove gimp gmusicbrowser gnome-power-manager gnome-screensaver gnome-termina* gnome-pane* gnome-applet* gnome-bluetooth gnome-desktop* gnome-mahjongg gnome-sessio* gnome-user* gnome-shell-common compiz compiz* unity unity* hud zeitgeist zeitgeist* python-zeitgeist libzeitgeist* activity-log-manager-common gnome-control-center gnome-screenshot nautilus overlay-scrollba* rhythmbox
RUN apt-get --assume-yes install xubuntu-community-wallpapers
RUN apt-get --assume-yes autoremove

#install openvpn
RUN apt-get --assume-yes install openvpn

#install command line text based browser
RUN apt-get --assume-yes install links

#install meld for comparing files in a gui
RUN apt-get --assume-yes install meld

#install curl
RUN apt-get --assume-yes install curl

#install vim as we need it to make vi use pathogen etc
RUN apt-get --assume-yes install vim

#cleanup
RUN apt-get --assume-yes autoremove

#download and install mysql workbench
RUN wget https://dev.mysql.com/get/Downloads/MySQLGUITools/mysql-workbench-community-6.3.6-1ubu1510-amd64.deb && apt-get --assume-yes install ./mysql-workbench-community-6.3.6-1ubu1510-amd64.deb && rm ./mysql-workbench-community-6.3.6-1ubu1510-amd64.deb

# Port to expose (default: 11211)
EXPOSE 11211
