# InfluxDB Role

## variables

### required variables

| name                     | example      |
| ------------------------ | ------------ |
| influxdb_hostname        | influx.local |
| influxdb_influx_password | password!    |
| influxdb_root_password   | password!    |



### optional variables

| name                  | example                           |
| --------------------- | --------------------------------- |
| influxdb_seed_servers | '\["other-influx.local:8090", \]' |




## example vagrant/playbook

### vagrantfile

```ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  vagrant_version = Vagrant::VERSION.sub(/^v/, '')

  config.vm.define "master" do |master|
    master.vm.box = "pixative/debian-wheezy-64"
    master.vm.hostname = "influx-master"
    master.vm.network "private_network", type: :dhcp
    master.vm.synced_folder ".", "/www/influx", owner: "www-data", group: "www-data", mount_options: ["dmode=755,fmode=755"]
    master.vm.provision :ansible do |ansible|
      ansible.playbook = "ansible/influx-master.yml"
    end
    master.vm.provider "virtualbox" do |v|
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    end
  end

  config.vm.define "slave01" do |slave|
    slave.vm.box = "pixative/debian-wheezy-64"
    slave.vm.hostname = "influx-slave01"
    slave.vm.network "private_network", type: :dhcp
    slave.vm.synced_folder ".", "/www/influx", owner: "www-data", group: "www-data", mount_options: ["dmode=755,fmode=755"]
    slave.vm.provision :ansible do |ansible|
      ansible.playbook = "ansible/influx-slave01.yml"
    end
    slave.vm.provider "virtualbox" do |v|
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    end
  end

  config.vm.define "slave02" do |slave|
    slave.vm.box = "pixative/debian-wheezy-64"
    slave.vm.hostname = "influx-slave02"
    slave.vm.network "private_network", type: :dhcp
    slave.vm.synced_folder ".", "/www/influx", owner: "www-data", group: "www-data", mount_options: ["dmode=755,fmode=755"]
    slave.vm.provision :ansible do |ansible|
      ansible.playbook = "ansible/influx-slave02.yml"
    end
    slave.vm.provider "virtualbox" do |v|
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    end
  end

end
```


### influx-master.yml

```yml
---
# Setting up the local virtual machine for influxdb and grafana

- hosts: all

  sudo: yes


  vars:
    influxdb_hostname: influx-master.local
    influxdb_repl_factor: 3
    grafana_influxdb_hostname: influx-master.local
    grafana_influxdb_database_name: influxdb
    grafana_influxdb_username: root
    grafana_influxdb_password: root


  pre_tasks:
    - name: make sure that vagrant has the right permissions
      lineinfile: 'dest=/etc/sudoers regexp="vagrant ALL=(ALL) NOPASSWD: ALL" line="vagrant ALL=(ALL) NOPASSWD: ALL"'


  roles:
    - avahi

    - nginx

    - influxdb

    - grafana


  post_tasks:
    - file: path=/var/www/.ssh/ state=directory owner=www-data group=www-data mode=700

    - file: path=/var/www/.ssh/bulbs_cms_keys/ state=directory owner=www-data group=www-data mode=700

    - copy: src=files/bulbs_cms_keys/id_rsa dest=/var/www/.ssh/bulbs_cms_keys/id_rsa owner=www-data group=www-data mode=600

    - copy: src=files/bulbs_cms_keys/id_rsa.pub dest=/var/www/.ssh/bulbs_cms_keys/id_rsa.pub owner=www-data group=www-data mode=644

    - copy: src=files/bulbs_cms_keys/ssh_config dest=/var/www/.ssh/config owner=www-data group=www-data

    - copy: src=files/bulbs_cms_keys/known_hosts dest=/var/www/.ssh/known_hosts owner=www-data group=www-data

    - authorized_key: user=www-data key="{{ lookup('file', '~/.ssh/id_rsa.pub') }}"

    - service: name=nginx state=restarted
```


### influx-slave.yml

```yml
---
# Setting up the local virtual machine for influxdb

- hosts: all

  sudo: yes


  vars:
    influxdb_hostname: influx-slave01.local
    influxdb_repl_factor: 3
    influxdb_seed_servers: '["influx-master.local:8090", ]'


  pre_tasks:
    - name: make sure that vagrant has the right permissions
      lineinfile: 'dest=/etc/sudoers regexp="vagrant ALL=(ALL) NOPASSWD: ALL" line="vagrant ALL=(ALL) NOPASSWD: ALL"'


  roles:
    - avahi

    - influxdb


  post_tasks:
    - file: path=/var/www/.ssh/ state=directory owner=www-data group=www-data mode=700

    - file: path=/var/www/.ssh/bulbs_cms_keys/ state=directory owner=www-data group=www-data mode=700

    - copy: src=files/bulbs_cms_keys/id_rsa dest=/var/www/.ssh/bulbs_cms_keys/id_rsa owner=www-data group=www-data mode=600

    - copy: src=files/bulbs_cms_keys/id_rsa.pub dest=/var/www/.ssh/bulbs_cms_keys/id_rsa.pub owner=www-data group=www-data mode=644

    - copy: src=files/bulbs_cms_keys/ssh_config dest=/var/www/.ssh/config owner=www-data group=www-data

    - copy: src=files/bulbs_cms_keys/known_hosts dest=/var/www/.ssh/known_hosts owner=www-data group=www-data

    - authorized_key: user=www-data key="{{ lookup('file', '~/.ssh/id_rsa.pub') }}"
```

















