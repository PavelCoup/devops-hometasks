#!/bin/bash

sudo touch /etc/httpd/conf.d/01-demosite-static.conf
cat <<PAST | sudo tee /etc/httpd/conf.d/01-demosite-static.conf
<VirtualHost *:80>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html/01-demosite-static
        DirectoryIndex index.html
</VirtualHost>
PAST

sudo touch /etc/httpd/conf.d/01-demosite-php.conf
cat <<PAST | sudo tee /etc/httpd/conf.d/01-demosite-php.conf
<VirtualHost *:81>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html/01-demosite-php
        DirectoryIndex index.php
</VirtualHost>
PAST

sudo sed -i.bak -e "/Listen 80/a Listen 81" /etc/httpd/conf/httpd.conf

sudo rm /etc/httpd/conf.d/welcome.conf
sudo chmod -R 775 /var/www/html
sudo restorecon -R /var/www/html/
sudo systemctl restart httpd


