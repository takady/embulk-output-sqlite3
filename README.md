# Sqlite3 output plugin for Embulk

embulk-output-sqlite3 provides output plugin for Embulk.

## Overview

* **Plugin type**: output
* **Load all or nothing**: no
* **Resume supported**: no
* **Cleanup supported**: yes

## Configuration

- **database**: path of sqlite3 database (string, required)
- **table**: name of insert table(string, required)

## Example

```yaml
out:
  type: sqlite3
  database: '/tmp/test.db'
  table: 'load01'
```


## Build

```
$ rake
```

## Contributing

1. Fork it ( https://github.com/takady/embulk-output-sqlite3/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
