#!/bin/bash

sudo apt-get remove aisleriot brasero cheesegnome-mahjongg gnome-mines gnome-sudoku gnomine rhythmbox-plugin-zeitgeist rhythmbox rhythmbox-plugin-cdrecorder rhythmbox-mozilla rhythmbox-plugin-magnitude rhythmbox-plugins shotwell shotwell-common simple-scan

sudo apt-get update

sudo add-apt-repository ppa:x2go/stable

sudo apt-get install docker.io git libfreetype6:i386 libsm6:i386 libxext6:i386 openssh-server php5-cli php5-curl putty-tools vim virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11 x2goserver x2goserver-xsession

#lose unitf gnome and add xmbc
sudo apt-get install xubuntu-desktop gksu leafpad synaptic
sudo apt-get remove gimp gmusicbrowser gnome-power-manager gnome-screensaver gnome-termina* gnome-pane* gnome-applet* gnome-bluetooth gnome-desktop* gnome-mahjongg gnome-sessio* gnome-user* gnome-shell-common compiz compiz* unity unity* hud zeitgeist zeitgeist* python-zeitgeist libzeitgeist* activity-log-manager-common gnome-control-center gnome-screenshot nautilus overlay-scrollba* rhythmbox && sudo apt-get install xubuntu-community-wallpapers && sudo apt-get autoremove

#install openvpn
sudo apt-get install openvpn

#install meld for comparing files in a gui
sudo apt-get install meld

#install scala build tool
echo "deb http://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
sudo apt-get update
sudo apt-get install sbt

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

#add sources so we can get zfs packages
deb http://ppa.launchpad.net/zfs-native/stable/ubuntu vivid main
deb-src http://ppa.launchpad.net/zfs-native/stable/ubuntu vivid main

#install zfs package
sudo apt-get install ubuntu-zfs

#create zfs tank over our 12 logical disks
zpool create -m /tank tank sdb sdc sdd sde sdf sdg sdh sdi sdj sdk sdl sdm

#set some zfs flags for compression dedupe
zfs set dedupe=on tank
zfs set dedup=fletcher4,verify tank
zfs set compression=gzip tank

#mount the volume every time the system boots
echo 'zfs_enable="YES"' >> /etc/rc.conf

#install antivirus
sudo apt-get install clamav-daemon
sudo freshclam
sudo /etc/init.d/clamav-daemon start

#download and install mysql workbench
wget http://dev.mysql.com/get/Downloads/MySQLGUITools/mysql-workbench-community-6.3.3-1ubu1404-amd64.deb
sudo apt-get install mysql-workbench-community-6.3.3-1ubu1404-amd64.deb

#install mysql command line client
sudo apt-get install mysql-client-core-5.6

#install skype
sudo dpkg --add-architecture i386
sudo add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
sudo apt-get update && sudo apt-get install skype pulseaudio:i386

#set terminal colours
setterm --term linux --back black --fore white --clear all

#download dot files from github
cd ~/
git clone https://github.com/craigmayhew/dotfiles.git
rsync -a dotfiles/ ~/
rm -rf ~/dotfiles

#download repos from github that I maintain
mkdir -p ~/gitrepos/mine
cd ~/gitrepos/mine
git clone https://github.com/craigmayhew/bigprimes.net.git
git clone https://github.com/craigmayhew/craig.mayhew.io.git
git clone https://github.com/craigmayhew/rai.git
git clone https://github.com/craigmayhew/rig.git
git clone https://github.com/craigmayhew/scratchpad.git

#as we have cloned the rig repo, we have a custom homepage, but we are currently forced to drop into sudo for this
sudo su
echo 'user_pref("browser.startup.homepage", "/home/user/gitrepos/mine/rig/homepage.html");' >> /etc/firefox/syspref.js
exit

#make the pretty git lg command available
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue) %an%Creset' --abbrev-commit"
#set git global options
git config --global color.diff auto
git config --global color.status auto
git config --global color.branch auto
git config --global color.interactive auto
git config --global color.ui auto
git config --global gc.auto 1

#add rai to crontab
(crontab -l ; echo "*/10 * * * * php /home/craig/gitrepos/mine/rai/cron.php rss")| crontab -
(crontab -l ; echo "*/30 * * * * php /home/craig/gitrepos/mine/rai/cron.php myip")| crontab -
