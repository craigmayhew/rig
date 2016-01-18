# Set the base image to use to Craig's version of Ubuntu
FROM craigmayhew/ws:latest

MAINTAINER Craig Mayhew

#install ethereum
RUN apt-get install software-properties-common
RUN add-apt-repository -y ppa:ethereum/ethereum
RUN add-apt-repository -y ppa:ethereum/ethereum-dev
RUN apt-get update
RUN apt-get install ethereum

#set your local address to 010101...
RUN eth --address 0101010101010101010101010

#mine with one thread to your address
RUN cd /home/user/
RUN wget http://jev.io/genesis_block.json
#RUN geth --mine --minerthreads=1 --genesis /home/user/genesis_block.json --etherbase 000101010101010101010101010101

RUN add-apt-repository ppa:ethereum/ethereum
RUN apt-get update
RUN apt-get install solc

#get to the geth console
#RUN geth -console

#report cpu hashrate
#RUN ethminer -M

#report gpu hash rate
#RUN ethminer -G -M
