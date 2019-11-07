#!/bin/bash
echo "Updating packages"
yum -y update
echo "Setting hostname"
hostnamectl set-hostname cunuqrpbx01.uqroo.mx
echo "Installing Epel-release"
yum -y install epel-release
echo "Installing dependencies"
yum -y install wget vim  net-tools
yum -y groupinstall "Development Tools"
yum -y install libedit-devel sqlite-devel psmisc gmime-devel ncurses-devel libtermcap-devel sox newt-devel libxml2-devel libtiff-devel audiofile-devel gtk2-devel uuid-devel libtool libuuid-devel subversion kernel-devel kernel-devel-$(uname -r) git subversion kernel-devel crontabs cronie cronie-anacron wget vim
echo "Downloading and installing jansson"
cd /usr/src/
git clone https://github.com/akheron/jansson.git
cd jansson
autoreconf  -i
./configure --prefix=/usr/
make && make install
echo "Downloading and isntalling PJSIP"
cd /usr/src/ 
export VER="2.8"
wget http://www.pjsip.org/release/${VER}/pjproject-${VER}.tar.bz2
tar -jxvf pjproject-${VER}.tar.bz2
cd pjproject-${VER}
./configure CFLAGS="-DNDEBUG -DPJ_HAS_IPV6=1" --prefix=/usr --libdir=/usr/lib64 --enable-shared --disable-video --disable-sound --disable-opencore-amr
make dep
make
make install
ldconfig
echo "Downloading and installing Asterisk"
cd /usr/src/
wget http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-16-current.tar.gz
tar xvfz asterisk-16-current.tar.gz
rm -f asterisk-16-current.tar.gz
cd asterisk-*
./configure --libdir=/usr/lib64
make menuselect
contrib/script/get_mp3.sh
cd /usr/src/asterisk-*
echo "Compiling and installing asterisk"
make
make install
make samples
make config
ldconfig
echo "Setting useras and permissions"
groupadd asterisk
useradd -r -d /var/lib/asterisk -g asterisk asterisk
usermod -aG audio,dialout asterisk
chown -R asterisk:asterisk /etc/asterisk
chown -R asterisk:asterisk /var/{lib,log,spool}/asterisk
chown -R asterisk:asterisk /usr/lib64/asterisk
echo "AST_USER='asterisk'" > /etc/sysconfig/asterisk
echo "AST_GROUP='asterisk'" >> /etc/sysconfig/asterisk
echo "runuser = asterisk ; The user to run as." > /etc/asterisk/asterisk.conf
echo "rungroup = asterisk ; The group to run as." >> /etc/asterisk/asterisk.conf
