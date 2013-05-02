#!/bin/bash 
set -e -x
export DEBIAN_FRONTEND=noninteractive

APACHE_HOST_NAME=my-scale-app
APACHE_HOST=/etc/apache2/sites-available/$APACHE_HOST_NAME
OUTFOLDER=/mnt/$APACHE_HOST_NAME

echo "suhosin.executor.include.whitelist=phar" >> /etc/php5/conf.d/suhosin.ini

# Prepare Git repository
mkdir -p /root/.ssh
touch /root/.ssh/config
echo "Host github.com" >> /root/.ssh/config
echo "StrictHostKeyChecking no" >> /root/.ssh/config

git clone -q --recursive https://github.com/wdalmut/my-scale-app.git $OUTFOLDER

/usr/bin/php $OUTFOLDER/composer.phar self-update -d $OUTFOLDER 
/usr/bin/php $OUTFOLDER/composer.phar install -d $OUTFOLDER

a2dissite default

# Create new VirtualHost
touch $APACHE_HOST
echo "<VirtualHost *:80>"                                                   >> $APACHE_HOST
echo "ServerAdmin dev@corley.it"                                            >> $APACHE_HOST
echo "ServerName app.walterdalmut.com"                                      >> $APACHE_HOST
echo "ServerAlias www.app.walterdalmut.com"                                 >> $APACHE_HOST
echo "SetEnv APPLICATION_ENV production"                                    >> $APACHE_HOST
echo "DocumentRoot $OUTFOLDER/src/web"                                      >> $APACHE_HOST
echo "<Directory $OUTFOLDER/src/web>"                                       >> $APACHE_HOST
echo "Options -Indexes FollowSymLinks MultiViews"                           >> $APACHE_HOST
echo "AllowOverride All"                                                    >> $APACHE_HOST
echo "Order allow,deny"                                                     >> $APACHE_HOST
echo "allow from all"                                                       >> $APACHE_HOST
echo "</Directory>"                                                         >> $APACHE_HOST
echo "ErrorLog syslog:local7"                                               >> $APACHE_HOST
echo "CustomLog \"|/usr/bin/logger -t apache2 -p local6.info\" combined"    >> $APACHE_HOST
echo "</VirtualHost>"                                                       >> $APACHE_HOST

a2ensite $APACHE_HOST_NAME


# Enable apache modules
a2enmod rewrite
a2enmod vhost_alias
a2enmod headers
a2enmod expires
a2enmod deflate
a2dismod autoindex
a2enmod ssl

/etc/init.d/apache2 restart

