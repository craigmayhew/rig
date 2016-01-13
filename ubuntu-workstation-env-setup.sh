#!/bin/bash

sudo apt-get remove aisleriot brasero cheesegnome-mahjongg gnome-mines gnome-sudoku gnomine rhythmbox-plugin-zeitgeist rhythmbox rhythmbox-plugin-cdrecorder rhythmbox-mozilla rhythmbox-plugin-magnitude rhythmbox-plugins shotwell shotwell-common simple-scan

sudo apt-get update

sudo apt-get install docker.io git libfreetype6:i386 libsm6:i386 libxext6:i386 openssh-server php5-cli php5-curl putty-tools vim virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11

#lose unitf gnome and add xmbc
sudo apt-get install xubuntu-desktop gksu leafpad synaptic
sudo apt-get remove gimp gmusicbrowser gnome-power-manager gnome-screensaver gnome-termina* gnome-pane* gnome-applet* gnome-bluetooth gnome-desktop* gnome-mahjongg gnome-sessio* gnome-user* gnome-shell-common compiz compiz* unity unity* hud zeitgeist zeitgeist* python-zeitgeist libzeitgeist* activity-log-manager-common gnome-control-center gnome-screenshot nautilus overlay-scrollba* rhythmbox && sudo apt-get install xubuntu-community-wallpapers && sudo apt-get autoremove

#install curl
sudo apt-get install curl

#install vim as we need it to make vi use pathogen etc
sudo apt-get install vim

#cleanup
sudo apt-get autoremove

#setup ssh server
cat >/etc/ssh/sshd_config <<EOL
# Package generated configuration file
# See the sshd_config(5) manpage for details
# What ports, IPs and protocols we listen for
Port 22
Protocol 2
# HostKeys for protocol version 2
HostKey /etc/ssh/ssh_host_rsa_key
HostKey /etc/ssh/ssh_host_dsa_key
HostKey /etc/ssh/ssh_host_ecdsa_key
HostKey /etc/ssh/ssh_host_ed25519_key
#Privilege Separation is turned on for security
UsePrivilegeSeparation yes
# Lifetime and size of ephemeral version 1 server key
KeyRegenerationInterval 3600
ServerKeyBits 1024
# Logging
SyslogFacility AUTH
LogLevel INFO
# Authentication:
LoginGraceTime 120
PermitRootLogin without-password
StrictModes yes
RSAAuthentication yes
PubkeyAuthentication yes
# Don't read the user's ~/.rhosts and ~/.shosts files
IgnoreRhosts yes
# For this to work you will also need host keys in /etc/ssh_known_hosts
RhostsRSAAuthentication no
# similar for protocol version 2
HostbasedAuthentication no
# Prevent password based authentication
PermitEmptyPasswords no
ChallengeResponseAuthentication no
PasswordAuthentication no
UsePAM no
X11Forwarding yes
X11DisplayOffset 10
PrintMotd no
PrintLastLog yes
TCPKeepAlive yes
# Allow client to pass locale environment variables
AcceptEnv LANG LC_*
Subsystem sftp /usr/lib/openssh/sftp-server
EOL

#install antivirus
sudo apt-get install clamav-daemon
sudo freshclam
sudo /etc/init.d/clamav-daemon start

#set terminal colours
setterm --term linux --back black --fore white --clear all

#download dot files from github
cd ~/
git clone https://github.com/craigmayhew/dotfiles.git
rsync -a dotfiles/ ~/
rm -rf ~/dotfiles

#we use this directory to hold our vim backup files
mkdir -p ~/.vim/tmp

#make the pretty git lg command available
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue) %an%Creset' --abbrev-commit"
#undo the last git commit
git config --global alias.undocommit "reset --soft HEAD~1"
#show the last commit as a diff
git config --global alias.last "diff HEAD~1 HEAD"

#set git global options
git config --global color.diff auto
git config --global color.status auto
git config --global color.branch auto
git config --global color.interactive auto
git config --global color.ui auto
git config --global gc.auto 1
git config --global push.default simple
git config --global branch.autosetuprebase always

#install hack font
mkdir ~/.fonts/
cd ~/.fonts/
wget https://github.com/chrissimpkins/Hack/raw/master/build/ttf/Hack-Bold.ttf
wget https://github.com/chrissimpkins/Hack/raw/master/build/ttf/Hack-BoldItalic.ttf
wget https://github.com/chrissimpkins/Hack/raw/master/build/ttf/Hack-Italic.ttf
wget https://github.com/chrissimpkins/Hack/raw/master/build/ttf/Hack-Regular.ttf
