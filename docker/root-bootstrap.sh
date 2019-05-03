#!/bin/bash
set -xe

apt-get update
apt-get install software-properties-common -y

DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade

apt-get -y --no-install-recommends install \
    avahi-daemon \
    bridge-utils \
    curl \
    git \
    git-review \
    htop \
    python2.7 \
    python2.7-dev \
    valgrind \
    zip unzip \
    tcpdump \
    vlan \
    sudo \
    iputils-ping \
    ntp \
    vim nano emacs \
    arping \
    gawk \
    texinfo \
    build-essential \
    iptables \
    automake \
    autoconf \
    libtool \
    isc-dhcp-server

DEBIAN_FRONTEND=noninteractive apt-get -yq install wireshark

# Install pip and some python deps (others are defined in install-p4-tools.sh)
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python2.7 get-pip.py --force-reinstall
rm -f get-pip.py
pip install ipaddress psutil

bash /root/user-bootstrap.sh
