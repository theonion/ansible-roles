
## variables

| name          | description                       | default               |
| ------------- | --------------------------------- | --------------------- |
| apps          | space-delimited list of app names | "avclub clickhole"    |
| host          | the hostname or ip of the cluster | localhost             |
| port          | connection port for http api      | 8086                  |
| username      | read/write user                   | root                  |
| password      | for `username`                    | root                  |
| db            | the database name                 | null                  |
| hourly_offset | influxdb formatted time offset    | "2h"                  |
| daily_offset  | influxdb formatted time offset    | "2d"                  |
