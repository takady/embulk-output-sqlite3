# Embulk::Plugin::Sqlite3

SQLite3 plugin for Embulk

## Installation

    $ embulk gem install embulk-plugin-sqlite3

## Configuration

```yaml
in:
  type: file
  paths: [/Users/takady/work/try1/csv]
  decoders:
  - {type: gzip}
  parser:
    charset: UTF-8
    newline: CRLF
    type: csv
    delimiter: ','
    quote: '"'
    header_line: true
    columns:
    - {name: id, type: long}
    - {name: account, type: long}
    - {name: time, type: timestamp, format: '%Y-%m-%d %H:%M:%S'}
    - {name: purchase, type: timestamp, format: '%Y%m%d'}
    - {name: comment, type: string}
exec: {}
out:
  type: sqlite3
  database: '/Users/takady/work/test.db'
  table: 'load01'
```

## Contributing

1. Fork it ( https://github.com/takady/embulk-plugin-sqlite3/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
