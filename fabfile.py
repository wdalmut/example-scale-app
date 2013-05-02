#! /usr/bin/env python
from cloth.tasks import *

env.user = "root"

env.directory = '/mnt/my-scale-app'
env.key_filename = ['/home/walter/Amazon/walter/tmp-corley-cms.pem']

@task
def pull():
    'Updates the repository.'
    with cd(env.directory):
        run('git pull origin master')

@task
def reload():
    "Reload Apache configuration"
    run('/etc/init.d/apache2 reload')

@task
def tail():
    "Tail Apache logs"
    run('tail /var/log/syslog')
