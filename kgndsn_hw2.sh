#!/bin/bash
sudo su
mkdir -p ~root/.ssh
cp ~vagrant/.ssh/auth* ~root/.ssh
yum install -y mdadm smartmontools hdparm gdisk
mdadm --zero-superblock --force /dev/sd{b,c,d,e,f}
mdadm --create --verbose /dev/md0 -l 6 -n 5 /dev/sd{b,c,d,e,f}
echo "DEVICE partitions" > /etc/mdadm.conf
mdadm --detail --scan --verbose | awk '/ARRAY/ {print}' >> /etc/mdadm.conf
parted -s /dev/md0 mklabel gpt
parted /dev/md0 mkpart primary ext4 0% 20%
parted /dev/md0 mkpart primary ext4 20% 40%
parted /dev/md0 mkpart primary ext4 40% 60%
parted /dev/md0 mkpart primary ext4 60% 80%
parted /dev/md0 mkpart primary ext4 80% 100%
for i in $(seq 1 5); do sudo mkfs.ext4 /dev/md0p$i; done
mkdir -p /raid/part{1,2,3,4,5}
for i in $(seq 1 5); do mount /dev/md0p$i /raid/part$i; done
echo "/dev/md0p1 /raid/part1 ext4 defaults 0 0" >> /etc/fstab
echo "/dev/md0p2 /raid/part2 ext4 defaults 0 0" >> /etc/fstab
echo "/dev/md0p3 /raid/part3 ext4 defaults 0 0" >> /etc/fstab
echo "/dev/md0p4 /raid/part4 ext4 defaults 0 0" >> /etc/fstab
echo "/dev/md0p5 /raid/part5 ext4 defaults 0 0" >> /etc/fstab
