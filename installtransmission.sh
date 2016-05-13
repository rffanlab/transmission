#!/bin/bash
#This script is written for setup Transmission from yum
#This script is written by rffanlab.com
#This script is tested only under CentOS 6 and CentOS 5
read -p "请输入你的管理员账号:" username
read -p "请输入你的官员密码:" password
yum install -y redhat-lsb
yum install -y wget
osrelease=$(lsb_release -rs|awk -F'.' '{print $1}')
dis=$(getconf LONG_BIT)
if [[ $osrelease = '6' ]]; then
  cd /etc/yum.repos.d/
  if [[ $dis = '64' ]]; then
    wget http://geekery.altervista.org/geekery-el6-x86_64.repo
  elif [[ $dis = '32' ]]; then
  wget http://geekery.altervista.org/geekery-el6-i686.repo
  fi
  yum install transmission transmission-daemon -y
  service transmission-daemon start
  service transmission-daemon stop
  pass=$(cat /var/lib/transmission/settings.json|grep 'rpc-password')
  sed -i "s/\"rpc-authentication-required\": false,/\"rpc-authentication-required\": true,/g" /var/lib/transmission/settings.json
  sed -i "s/\"rpc-username\": "",/\"rpc-username\": \"$username\",/g" /var/lib/transmission/settings.json
  sed -i "s/$pass/\"rpc-password\": \"$password\",/g" /var/lib/transmission/settings.json
  sed -i "s/\"rpc-whitelist-enabled\": true,/\"rpc-whitelist-enabled\": false,/g" /var/lib/transmission/settings.json
  sed -i "s/\"rpc-enabled\": false,/\"rpc-enabled\": true,/g" /var/lib/transmission/settings.json
elif [[ $osrelease = '5' ]]; then
  cd /etc/yum.repos.d/
  if [[ $dis = '64' ]]; then
  wget http://geekery.altervista.org/geekery-el5-x86_64.repo
  elif [[ $dis = '32' ]]; then
  wget http://geekery.altervista.org/geekery-el5-i386.repo
  fi
  yum install transmission transmission-daemon -y
  service transmission-daemon start
  service transmission-daemon stop
  pass=$(cat /var/lib/transmission/.config/transmission-daemon/settings.json|grep 'rpc-password')
  sed -i "s/\"rpc-authentication-required\": false,/\"rpc-authentication-required\": true,/g" /var/lib/transmission/.config/transmission-daemon/settings.json
  sed -i "s/\"rpc-username\": "",/\"rpc-username\": "$username",/g" /var/lib/transmission/.config/transmission-daemon/settings.json
  sed -i "s/$pass/\"rpc-password\": \"$password\",/g" /var/lib/transmission/.config/transmission-daemon/settings.json
  sed -i "s/\"rpc-whitelist-enabled\": true,/\"rpc-whitelist-enabled\": false,/g" /var/lib/transmission/.config/transmission-daemon/settings.json
  sed -i "s/\"rpc-enabled\": false,/\"rpc-enabled\": true,/g" /var/lib/transmission/.config/transmission-daemon/settings.json
fi
