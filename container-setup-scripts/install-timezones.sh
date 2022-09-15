#! /bin/sh

ln -fs /usr/share/zoneinfo/UTC /etc/localtime 
export DEBIAN_FRONTEND=noninteractive 
apt-get update 
apt-get install -y tzdata 
dpkg-reconfigure --frontend noninteractive tzdata