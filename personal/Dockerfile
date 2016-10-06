############################################################
# Dockerfile to run Craigs Workstation
# Based on Ubuntu Image
#
# Useful commands:
#   docker build -t cmdock -f Dockerfile .
#   docker run -i -t cmdock
#   docker run -i -t -v /home/user craigmayhew/wspersonal /bin/bash
#   docker run -i -t -u user -v /home/user:/home/user craigmayhew/wspersonal /bin/bash
############################################################

# Set the base image to use to Ubuntu
FROM craigmayhew/ws:latest

MAINTAINER Craig Mayhew

# run this to prevent the language question breaking apt-get further down this list of commands
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Update the default application repository sources list
RUN apt-get --assume-yes update

# cleanup
RUN apt-get --assume-yes autoremove


# download dot files from github
RUN cd /home/user/ && git clone https://github.com/craigmayhew/dotfiles.git && rsync -a dotfiles/ /home/user/ && rm -rf /home/user/dotfiles

# set git info
RUN git config --global user.email "craig@mayhew.io"
RUN git config --global user.name "Craig Mayhew"

# download repos from github that I maintain
RUN mkdir -p /home/user/gitrepos/mine && cd /home/user/gitrepos/mine && git clone https://github.com/craigmayhew/craig.mayhew.io.git
RUN mkdir -p /home/user/gitrepos/mine && cd /home/user/gitrepos/mine && git clone https://github.com/craigmayhew/rig.git
RUN mkdir -p /home/user/gitrepos/mine && cd /home/user/gitrepos/mine && git clone https://github.com/craigmayhew/scratchpad.git

# Port to expose (default: 11211)
EXPOSE 11211
