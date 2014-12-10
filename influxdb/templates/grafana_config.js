define(['settings'], function (Settings) {

  return new Settings({

    datasources: {
      oniontv: {
        type: 'influxdb',
        url: "http://influx.local:8086/db/oniontv",
        username: 'root',
        password: 'root',
        default: true
      },

      grafana: {
        type: 'influxdb',
        url: "http://influx.local:8086/db/grafana",
        username: 'root',
        password: 'root',
        grafanaDB: true
      }
    },

    search: {
      max_results: 10000
    },

    default_route: '/dashboard/file/default.json',

    unsaved_changes_warning: true,

    playlist_timespan: "1m",

    admin: {
      password: ''
    },

    window_title_prefix: 'Grafana - ',

    plugins: {
      panels: [],
      dependencies: []
    }

  });
});
