# uWSGI

This role installs and configures uWSGI in [Emperor](http://uwsgi-docs.readthedocs.org/en/latest/Emperor.html) mode, either from aptitude, pip, or from source.

If installing from pip or from source, the configuration will be very similar to the debian package. A /etc/init.d/uwsgi script will be created, which takes values from /etc/default/uwsgi, and looks for new uwsgi config files in /etc/uwsgi/apps-enabled/.

By default, this role installs the latest version of uWSGI using pip. Here are a couple of usage examples:

```YAML
---
# Install the latest uWSGI version from pip
- hosts: all
  roles:
    - uwsgi
```

```YAML
---
# Install uWSGI version 1.9.20 from source
- hosts: all
  roles:
    - uwsgi
  vars:
    uwsgi_install_method: source
    uwsgi_version: 1.9.20
```

```YAML
---
# Install the latest uWSGI version from apt
- hosts: all
  roles:
    - uwsgi
  vars:
    uwsgi_install_method: apt
```