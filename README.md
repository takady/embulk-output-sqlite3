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
