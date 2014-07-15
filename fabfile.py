#! /usr/bin/env python
from __future__ import with_statement
from fabric.api import *
from fabric.contrib.console import confirm

from cloth.tasks import *

env.user = "ubuntu"

env.directory = '/mnt/app'
env.key_filename = ['~/Amazon/walterdalmut/tmp-corley-cms.pem']

@task
def pull():
    'Updates the repository.'
    with cd(env.directory):
        sudo('git pull origin master')


@task
def reload():
    "Reload Apache configuration"
    run('/etc/init.d/apache2 reload')

@task
def tail():
    "Tail Apache logs"
    run('tail /var/log/apache2/access.log')

@task
def remove_app():
    sudo("rm -rf /mnt/app")

@task
def install_app():
    "Install my application"
    sudo("apt-get update")
    sudo("apt-get install -y apache2 libapache2-mod-php5 php5-dev git php5-memcached")
    sudo('a2enmod rewrite')
    sudo('service apache2 restart')
    sudo("git clone https://github.com/wdalmut/example-scale-app.git /mnt/app")
    put("000-default", "/etc/apache2/sites-available/000-default.conf", True)
    sudo("service apache2 restart")
    with cd(env.directory):
        sudo("php composer.phar install")

