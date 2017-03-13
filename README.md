# America's Finest Ansible Roles

This repo is an attempt to make some reusable, well tested ansible roles for ubuntu/debian systems. These roles will include:

- [x] uwsgi
- [x] uwsgi-python-app
- [x] collectd
- [x] nginx
- [x] memcached
- [x] elasticsearch
- [x] elasticsearch-1.5
- [ ] postgresql
- [x] redis
- [x] rabbitmq
- [x] nodejs

# Testing

Each test case is a single playbook, which is run on a fresh VM. You'll want to have a version of Vagrant > 1.4.

To run all tests:

    $ ./runtests.sh

To run specific tests:

    $ ./runtests.sh uwsgi-source-install.yml uwsgi-pip-install.yml
