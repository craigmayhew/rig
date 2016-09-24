############################################################
# Dockerfile to run Craigs CRC Workstation
# Based on Ubuntu Image
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

# install arc for phabricator
RUN mkdir -p /home/user/gitrepos/others && cd /home/user/gitrepos/others && git clone https://github.com/phacility/libphutil.git && git clone https://github.com/phacility/arcanist.git && export PATH="$PATH:/home/user/gitrepos/others/arcanist/bin"

#install sencha tools
RUN apt-get install --assume-yes openjdk-7-jre && wget http://192.168.15.235/sencha/cmd-6.0.0.202-linux-amd64.zip && unzip cmd-6.0.0.202-linux-amd64.zip && ./SenchaCmd-6.0.0.202-linux-amd64.sh && ln -s /home/user/bin/Sencha/Cmd/sencha /usr/bin/sencha

# Port to expose (default: 11211)
EXPOSE 11211
