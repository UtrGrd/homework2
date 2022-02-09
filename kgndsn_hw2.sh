#!/bin/bash
sudo su
mkdir -p ~root/.ssh
cp ~vagrant/.ssh/auth* ~root/.ssh
yum install -y mdadm smartmontools hdparm gdisk
mdadm --zero-superblock --force /dev/sd{b,c,d,e,f}
mdadm --create --verbose /dev/md0 -l 6 -n 5 /dev/sd{b,c,d,e,f}
echo "DEVICE partitions" > /etc/mdadm.conf
mdadm --detail --scan --verbose | awk '/ARRAY/ {print}' >> /etc/mdadm.conf
