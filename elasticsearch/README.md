# elasticsearch

This role installs and configures elasticsearch from aptitude, by adding the [elasticsearch repositories](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/_apt.html).

By default, version 0.90.10 is installed, but this can be changed by setting the variable `elasticsearch_version`.

`elasticsearch_settings` can be used to configure any of the elasticsearch settings.

Plugins are added in accordance with the `elasticsearch_plugins` list.