# America's Finest Ansible Roles

This repo is an attempt to make some reusable, well tested ansible roles for ubuntu/debian systems. These roles will include:

- [x] uwsgi
- [ ] uwsgi-python-app
- [ ] collectd
- [ ] nginx
- [ ] memcached
- [ ] elasticsearch
- [ ] postgresql
- [ ] redis
- [ ] rabbitmq
- [ ] nodejs

# Testing

Each test case is a single playbook, which is run on a fresh VM.

To run all tests:

    $ ./runtests.sh

To run specific tests:

    $ ./runtests.sh uwsgi-source-install.yml uwsgi-pip-install.yml