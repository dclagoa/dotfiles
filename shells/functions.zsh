#!/usr/bin/env zsh

function batch_scp() {

# Batch copy a file to all hosts defined in .ssh/config with scp
# Used to send a private file who shouldn't be hosted on github to
# all your servers, like .ssh/config 

if [ ! -e $(which awk) ];then
    echo "Awk not found"
elif [ -z "$1" ];then
    echo "Please provide the file to be copied"
elif [ ! -f "$1" ];then
    echo "File $1 not found"
else
    echo "Copying $1"
    for x in $(awk '/^Host/ {print $NF}' ~/.ssh/config); do
        echo "Copying file to $x"
        scp $1 $x:$1
    done
fi
}

function test_writespeed() {
 dd if=/dev/zero of=test_512M bs=1024k count=512 conv=fdatasync;
 rm -rf test_512M;
}

function ipecho() {

#Gets the server external IP

CURL=$(which curl);
WGET=$(which wget);

URL="http://ipecho.net/plain";

if [ -f $CURL ]; then
    IP=$($CURL -s $URL);
elif [ -f $WGET ]; then
    IP=$($WGET -qO- $URL);
else
    echo "Please install wget or curl";
    return
fi
echo $IP
}

