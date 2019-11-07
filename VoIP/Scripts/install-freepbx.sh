#!/bin/bash
#Referencias de instalacion https://computingforgeeks.com/how-to-install-freepbx-15-on-centos-7/
yum install -y mariadb-server httpd php56w php56w-opcache php56w-xml php56w-mcrypt php56w-gd php56w-devel php56w-mysql php56w-intl php56w-mbstring php56w-pear php56w-process mariadb-server mariadb httpd gnutls-devel unixODBC mysql-connector-odbc php56w-imap php56w-snmp php56w-bcmath
systemctl start mariadb
systemctl enable mariadb
systemctl start httpd
systemctl enable httpd
mysql_secure_installation
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
pear install Console_Getopt
cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf_orig
sed -i 's/^\(User\|Group\).*/\1 asterisk/' /etc/httpd/conf/httpd.conf
sed -i 's/AllowOverride None/AllowOverride All/' /etc/httpd/conf/httpd.conf
systemctl restart httpd
cd /usr/src
wget http://mirror.freepbx.org/modules/packages/freepbx/freepbx-14.0-latest.tgz
tar xfz freepbx-14.0-latest.tgz
rm -f freepbx-14.0-latest.tgz
cd freepbx
systemctl stop asterisk
./start_asterisk start
./install -n --dbuser=root --dbpass=CONTRASEÑA_MYSQL
firewall-cmd --add-service={http,https} --permanent
firewall-cmd --reload