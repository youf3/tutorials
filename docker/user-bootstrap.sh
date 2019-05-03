#!/bin/bash
set -xe

cp /etc/skel/.bashrc ~/
cp /etc/skel/.profile ~/
cp /etc/skel/.bash_logout ~/

# Build and install P4 tools
bash /vagrant/install-p4-tools.sh
# We'll delete bmv2 sources later...
cp ~/p4tools/bmv2/tools/veth_setup.sh ~/veth_setup.sh
cp ~/p4tools/bmv2/tools/veth_teardown.sh ~/veth_teardown.sh

# Mininet
git clone git://github.com/mininet/mininet
/mininet/util/install.sh -nv

#fix issue for mininet
ovsdb-server --remote=punix:*/var/run/openvswitch/db.sock* \
--remote=db:Open_vSwitch,Open_vSwitch,manager_options \
--private-key=db:Open_vSwitch,SSL,private_key \
--certificate=db:Open_vSwitch,SSL,certificate \
--bootstrap-ca-cert=db:Open_vSwitch,SSL,ca_cert --pidfile --detach

ovs-vsctl --no-wait init
ovs-vswitchd --pidfile --detach


# FIXME: for some reason protobuf python bindings are not properly installed
cd ~/p4tools/protobuf/python
pip install .

#download the tutorial repo
cd
git clone -b bmv2_only_tutorial https://github.com/youf3/tutorials.git
