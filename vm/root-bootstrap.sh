#!/bin/bash
set -xe

VM_TYPE=${1:-dev}

# Create user sdn
useradd -m -d /home/sdn -s /bin/bash sdn
echo "sdn:rocks" | chpasswd
echo "sdn ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/99_sdn
chmod 440 /etc/sudoers.d/99_sdn
usermod -aG vboxsf sdn
update-locale LC_ALL="en_US.UTF-8"

if [ ${VM_TYPE} = "tutorial" ]
then
    su sdn <<'EOF'
cd /home/sdn
bash /vagrant/tutorial-bootstrap.sh
EOF
fi
apt-get update
apt-get install software-properties-common -y

DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade

apt-get -y --no-install-recommends install \
    avahi-daemon \
    bridge-utils \
    git \
    git-review \
    htop \
    python2.7 \
    python2.7-dev \
    valgrind \
    zip unzip \
    tcpdump \
    vlan \
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

tee -a /etc/ssh/sshd_config <<EOF

UseDNS no
EOF

su sdn <<'EOF'
cd /home/sdn
bash /vagrant/user-bootstrap.sh
EOF
