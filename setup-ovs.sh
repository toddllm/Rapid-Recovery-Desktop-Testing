#!/bin/bash

#ovs setup

#comment out during testing
#wget http://openvswitch.org/releases/openvswitch-1.0.1.tar.gz

#
sudo yum install make gcc openssl-devel kernel-devel kernel-headers


tar xf openvswitch-1.0.1.tar.gz
cd openvswitch-1.0.1

./configure --with-l26=/lib/modules/`uname -r`/build --enable-ssl=yes
make
sudo make install
sudo insmod datapath/linux-2.6/openvswitch_mod.ko
sudo /usr/local/bin/ovsdb-tool create /usr/local/etc/ovs-vswitchd.conf.db vswitchd/vswitch.ovsschema
sudo /usr/local/sbin/ovsdb-server /usr/local/etc/ovs-vswitchd.conf.db --remote=punix:/usr/local/var/run/openvswitch/db.sock
sudo /usr/local/bin/ovs-vsctl init
sudo /usr/local/sbin/ovs-vswitchd unix:/usr/local/var/run/openvswitch/db.sock
