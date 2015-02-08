# SQLite3 plugin for Embulk

embulk-plugin-sqlite3 provides output plugin for Embulk

## Installation

    $ embulk gem install embulk-plugin-sqlite3

## Configuration

```yaml
out:
  type: sqlite3
  database: '/tmp/test.db'
  table: 'load01'
```

## TODO

- implement input pugin

## Contributing

1. Fork it ( https://github.com/takady/embulk-plugin-sqlite3/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
