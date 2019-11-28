#!/bin/bash
yum -y install wget httpd wireshark php php-gd php-mysql php-mbstring mtr php-process librsvg2 librsvg2-tools urw-fonts mariadb-server
cd /var/www/html
wget "http://www.voipmonitor.org/download-gui?version=latest&major=5&allowed&phpver=54" -O w.tar.gz
tar xzf w.tar.gz
mv voipmonitor-gui*/* ./
rm -f index.html
chown apache /var/spool/voipmonitor/
wget http://sourceforge.net/projects/voipmonitor/files/wkhtml/0.10.0_rc2/wkhtmltoimage-x86_64 -O "/var/www/html/bin/wkhtmltoimage-x86_64"
chmod +x "/var/www/html/bin/wkhtmltoimage-x86_64"
wget http://sourceforge.net/projects/voipmonitor/files/wkhtml/0.10.0_rc2/wkhtmltopdf-x86_64 -O "/var/www/html/bin/wkhtmltopdf-x86_64"
chmod +x "/var/www/html/bin/wkhtmltopdf-x86_64"
wget http://voipmonitor.org/ioncube/x86_64/ioncube_loader_lin_5.4.so -O /usr/lib64/php/modules/ioncube_loader_lin_5.4.so
echo "zend_extension = /usr/lib64/php/modules/ioncube_loader_lin_5.4.so" > /etc/php.d/01_ioncube.ini
chown -R apache /var/www/html
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
setenforce 0
systemctl restart httpd.service
#For alerts/reports
echo " * * * * * root php /var/www/html/php/run.php cron" >> /etc/crontab
kill -HUP `pgrep cron`
wget http://sourceforge.net/projects/voipmonitor/files/wkhtml/phantomjs-2.1.1-x86_64.gz/download -O '/var/www/html/bin/phantomjs-2.1.1-x86_64.gz'
gunzip '/var/www/html/bin/phantomjs-2.1.1-x86_64.gz'
chmod +x '/var/www/html/bin/phantomjs-2.1.1-x86_64'
wget http://sourceforge.net/projects/voipmonitor/files/wkhtml/sox-x86_64.gz/download -O '/var/www/html/bin/sox-x86_64.gz'
gunzip '/var/www/html/bin/sox-x86_64.gz'
chmod +x '/var/www/html/bin/sox-x86_64'
wget http://sourceforge.net/projects/voipmonitor/files/wkhtml/tshark-2.3.0.3-x86_64.gz/download -O '/var/www/html/bin/tshark-2.3.0.3-x86_64.gz'
gunzip '/var/www/html/bin/tshark-2.3.0.3-x86_64.gz'
chmod +x '/var/www/html/bin/tshark-2.3.0.3-x86_64'
wget http://sourceforge.net/projects/voipmonitor/files/wkhtml/mergecap-2.3.0.3-x86_64.gz/download -O '/var/www/html/bin/mergecap-2.3.0.3-x86_64.gz'
gunzip '/var/www/html/bin/mergecap-2.3.0.3-x86_64.gz'
chmod +x '/var/www/html/bin/mergecap-2.3.0.3-x86_64'
wget http://sourceforge.net/projects/voipmonitor/files/wkhtml/t38_decode-2-i686.gz/download -O '/var/www/html/bin/t38_decode-2-i686.gz'
gunzip '/var/www/html/bin/t38_decode-2-i686.gz'
chmod +x '/var/www/html/bin/t38_decode-2-i686'
wget http://sourceforge.net/projects/voipmonitor/files/wkhtml/phantomjs-2.1.1-x86_64.gz/download -O '/var/www/html/bin/phantomjs-2.1.1-x86_64.gz'
gunzip '/var/www/html/bin/phantomjs-2.1.1-x86_64.gz'
chmod +x '/var/www/html/bin/phantomjs-2.1.1-x86_64'