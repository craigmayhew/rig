############################################################
# Dockerfile to run Craigs Workstation
# Based on Ubuntu Image
############################################################

# Set the base image to use to Ubuntu
FROM craigmayhew/wscrc:latest

MAINTAINER Craig Mayhew

# run this to prevent the language question breaking apt-get further down this list of commands
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Update the default application repository sources list
RUN apt-get --assume-yes update

# cleanup
RUN apt-get --assume-yes autoremove

# download and install mysql workbench
RUN wget https://dev.mysql.com/get/Downloads/MySQLGUITools/mysql-workbench-community-6.3.6-1ubu1510-amd64.deb && apt-get --assume-yes install ./mysql-workbench-community-6.3.6-1ubu1510-amd64.deb && rm ./mysql-workbench-community-6.3.6-1ubu1510-amd64.deb

# set terminal colours
RUN setterm --term linux --back black --fore white --clear all

# download dot files from github
RUN cd /home/user/ && git clone https://github.com/craigmayhew/dotfiles.git && rsync -a dotfiles/ /home/user/ && rm -rf /home/user/dotfiles

# install arc for phabricator
RUN mkdir -p /home/user/gitrepos/others && cd /home/user/gitrepos/others && git clone https://github.com/phacility/libphutil.git && git clone https://github.com/phacility/arcanist.git && export PATH="$PATH:/home/user/gitrepos/others/arcanist/bin"

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
RUN mkdir -p /home/user/.fonts/ && cd /home/user/.fonts/ && wget https://github.com/chrissimpkins/Hack/raw/master/build/ttf/Hack-Bold.ttf && wget https://github.com/chrissimpkins/Hack/raw/master/build/ttf/Hack-BoldItalic.ttf && wget https://github.com/chrissimpkins/Hack/raw/master/build/ttf/Hack-Italic.ttf && wget https://github.com/chrissimpkins/Hack/raw/master/build/ttf/Hack-Regular.ttf

# Port to expose (default: 11211)
EXPOSE 11211
