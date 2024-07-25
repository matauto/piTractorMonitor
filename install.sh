#!/usr/bin/env bash

#on SD card install current rasbian 64-bit OS version lite(without desktop)
#https://www.raspberrypi.com/software/operating-systems/
#enable SSH by edit file on SD card
#https://www.raspberrypi.com/documentation/computers/remote-access.html#ssh
#connect with SSH
#run this script
#do not connect to internet, before you change password

#first thing change password
echo "Change password" 
sudo passwd
#disable autologin
#https://www.raspberrypi.com/software/operating-systems/
echo "Disable autologin" 
sudo systemctl set-default multi-user.target
sudo ln -fs /lib/systemd/system/getty@.service /etc/systemd/system/getty.target.wants/getty@tty1.service
sudo mv /etc/systemd/system/getty@tty1.service.d/autologin.conf ~/autologin.conf.bak

#create new not sudo user to use for application
#you will be prompted to give answears for questions
echo "Create non sudo user for application host"
appUser="piMonitor"
sudo adduser $appUser
#add piMonitor user to groups
#TODO no idea now for which one
#sudo adduser piMonitor <group>

#add user only for ssh connection 
#disable SSH access for other users also pi
#you can switch to pi user using "su pi" command
#or give sudo to new user and delete pi
echo "Create user only for SSH connection"
read -p "Enter user: " userSSH
sudo adduser "$userSSH"
sudo echo "AllowUsers $userSSH" >> /etc/ssh/sshd_config 
#sudo adduser $userSSH sudo
#su $userSSH
#sudo deluser pi

#configure WiFi to connect to android phone for SSH and internet access
#TODO sudo raspi-config --> WiFi

#install required software and libraries
sudo apt-get update
sudo apt-get upgrade
#cario for frontEnd
sudo apt-get install libcairo2-dev
#
#sudo apt-get install

#
