#!/bin/bash
set -xe

cp /etc/skel/.bashrc ~/
cp /etc/skel/.profile ~/
cp /etc/skel/.bash_logout ~/

# Build and install P4 tools
bash /root/tutorials/docker/install-p4-tools.sh
# We'll delete bmv2 sources later...
cp ~/p4tools/bmv2/tools/veth_setup.sh ~/veth_setup.sh
cp ~/p4tools/bmv2/tools/veth_teardown.sh ~/veth_teardown.sh

# Mininet
git clone git://github.com/mininet/mininet
/mininet/util/install.sh -nv
service openvswitch-switch start


# FIXME: for some reason protobuf python bindings are not properly installed
cd ~/p4tools/protobuf/python
pip install .

