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
#  sed -i "s///g"
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
fi
