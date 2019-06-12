# Configuration

## Table of Contents

- [Overriding Configuration](#user-content-overriding-configuration)
- [Application Version](#user-content-application-version)
- [Database Settings](#user-content-database-settings)
- [Dump Settings](#user-content-dump-settings)
- [Table Whitelist](#user-content-table-whitelist)
- [Table Blacklist](#user-content-table-blacklist)
- [Tables Configuration](#user-content-tables-configuration)
    - [Tables to Truncate](#user-content-tables-to-truncate)
    - [Filtering Values](#user-content-filtering-values)
    - [Data Converters](#user-content-data-converters)
    - [Sharing Converter Results](#user-content-sharing-converter-results)
- [Version-specific Configuration](#user-content-version-specific-configuration)

## Overriding Configuration

You can create a custom config file that inherits the properties of another config file, by specifying the following parameter:

```yaml
extends: path/to/config/file.yaml
```

If you override a default template, the path to the file and the extension may be omitted:

```yaml
extends: magento2
```

It is also possible to override multiple config files:

```yaml
extends:
  - magento2
  - path/to/config/file.yaml
```

In the above example, the files will be loaded in this order:

1. config/templates/magento2.yml
2. path/to/config/file.yml
3. your config file

## Application Version

Some templates (e.g. `magento2`) require to specify the version of the application.

The version is required if the template file contains the `if_version` parameter (version-specific configuration).

To define the application version:

```yaml
extends: 'magento2'
version: '2.2.8'
```

## Database Settings

The database information can be specified in the `dababase` object:

```yaml
database:
    host: 'my_host'
    user: 'my_user'
    password: 'my_password'
    name: 'my_db_name'
```

Only the `name` parameter is required.
Other parameters are optional.

Available parameters:

| Parameter | Required | Default | Description |
| --- | --- | --- | --- |
| **name** | Y | | Database name. |
| **user** | N | `'root'` | Database user. |
| **password** | N | `''` | Database password. |
| **host** | N | `'localhost'` | Database host. |
| **port** | N | `'3306'` | Database port. |
| **driver** | N | `'pdo_mysql'` | Database driver. Only `pdo_mysql` is supported as of now. |
| **pdo_settings** | N | `[]` | An array of [PDO settings](https://www.php.net/manual/en/ref.pdo-mysql.php#pdo-mysql.constants). |

If command-line options are specified (e.g. `--user`), they will have priority over the parameter in the configuration file.

## Dump Settings

```yaml
dump:
    output: 'my_dump_file.sql'
```

Dump settings are all optional.

Available settings:

| Parameter | Default | Description |
| --- | --- | --- |
| **output** | `'php://stdout'` | Dump output. By default, the dump is outputted to the terminal. |
| **compress** | `'none'` | gzip, bzip2, none. |
| **init_commands** | `[]` | Queries executed after the connection is established. |
| **add_drop_database** | `false` | [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/mysqldump.html#option_mysqldump_add-drop-database) |
| **add_drop_table** | `true` | [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/mysqldump.html#option_mysqldump_add-drop-table) |
| **add_drop_trigger** | `true` | [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/mysqldump.html#option_mysqldump_add-drop-trigger) |
| **add_locks** | `true` | [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/mysqldump.html#option_mysqldump_add-locks) |
| **complete_insert** | `false` | [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/mysqldump.html#option_mysqldump_complete-insert) |
| **default_character_set** | `'utf8'` | utf8 (default, compatible option), utf8mb4 (for full utf8 compliance). |
| **disable_keys** | `true` | [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/mysqldump.html#option_mysqldump_disable-keys) |
| **extended_insert** | `true` | [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/mysqldump.html#option_mysqldump_extended-insert) |
| **events** | `false` | [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/mysqldump.html#option_mysqldump_events) |
| **hex_blob** | `false` | [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/mysqldump.html#option_mysqldump_hex-blob) |
| **insert_ignore** | `false` | [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/mysqldump.html#option_mysqldump_insert-ignore) |
| **net_buffer_length** | `1000000` | [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/mysqldump.html#option_mysqldump_net-buffer-length) |
| **no_autocommit** | `true` | Option to disable autocommit (faster inserts, no problems with index keys). |
| **no_create_info** | `false` | [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/mysqldump.html#option_mysqldump_no-create-info) |
| **lock_tables** | `false` | [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/mysqldump.html#option_mysqldump_lock-tables) |
| **routines** | `false` | [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/mysqldump.html#option_mysqldump_routines) |
| **single_transaction** | `true` | [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/mysqldump.html#option_mysqldump_single-transaction) |
| **skip_triggers** | `false` | [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/mysqldump.html#option_mysqldump_triggers) |
| **skip_tz_utc** | `false` | [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/mysqldump.html#option_mysqldump_tz-utc) |
| **skip_comments** | `false` | [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/mysqldump.html#option_mysqldump_comments) |
| **skip_dump_date** | `false` | [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/mysqldump.html#option_mysqldump_dump-date) |
| **skip_definer** | `false` | [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/mysqlpump.html#option_mysqlpump_skip-definer) |

### Table Whitelist

You can specify a list of tables to include in the dump.
If a whitelist is defined, only these tables will be dumped.

```yaml
tables_whitelist:
    - 'table1'
    - 'table2'
```

The wildcard character `*` can be used in table names (e.g. `cache_*`).

### Table Blacklist

You can specify a list of tables to exclude from the dump:

```yaml
tables_blacklist:
    - 'table1'
    - 'table2'
```

If a table is both blacklisted and whitelisted, it will not be included in the dump.

The wildcard character `*` can be used in table names (e.g. `cache_*`).

## Tables Configuration

The configuration of each table must be specified in the `tables` parameter.

```yaml
tables:
    table1:
        # ...
    table2:
        # ...
```

The wildcard character `*` can be used in table names (e.g. `cache_*`).

### Tables to Truncate

You can specify tables to include without any data (no insert query).

```yaml
tables:
    my_table:
        truncate: true
```

If there are tables with foreign keys to this table, they will also be automatically filtered.

### Filtering Values

It is possible to limit the data dumped for each table.

```yaml
tables:
    my_table:
        limit: 10000
```

The data is automatically filtered for all tables that depend on the target table (foreign keys).

Available properties:

- `limit`: to limit the number of rows to dump
- `orderBy`: same as SQL (e.g. `name asc, id desc`)
- `filters`: a list of filters to apply

The limit must be greater or equal than zero. If set to 0, it will be ignored.
Use the `truncate` property if you need to empty a table.

How to define a sort order:

```yaml
tables:
    my_table:
        orderBy: 'sku, entity_id desc'
        
```

How to define a filter:

```yaml
tables:
    my_table:
        filters:
            - ['id', 'gt', 1000]
            - ['sku', 'isNotNull']
            - ['type', 'in', ['simple', 'configurable']]
```

Available filter operators:

- `eq` (equal to)
- `gt` (greater than)
- `lt` (less than)
- `ge` (greater than or equal to)
- `le` (less than or equal to)
- `like`
- `notLike`
- `isNull` (no value)
- `isNotNull` (no value)
- `in` (value must be an array)
- `notIn` (value must be an array)

To use an expression, you can prefix the value by `expr:`:

```yaml
tables:
    my_table:
        filters:
            - ['updated_at', 'gt', 'expr: DATE_SUB(now(), INTERVAL 30 DAY)']
            - ['website_id', 'eq', 'expr: (SELECT website_id FROM store_website WHERE name = "base")']
```

Note: as of now, it is impossible to define expressions with the `in` and `notIn` operators, because the value must be an array of scalar values.

### Data Converters

It is possible to define data converters for any column.

Short syntax:

```yaml
tables:
    my_table:
        converters:
            my_column: 'randomizeEmail'
```

The key is the column name, the value is the converter name.

Extended syntax:

```yaml
tables:
    my_table:
        converters:
            my_column:
                converter: 'randomizeEmail'
                unique: true
```

The key is the column name, the value is the converter definition.

List of available properties:

| Property | Required | Default | Description |
| --- | --- | --- | --- |
| **converter** | Y | | Converter name. A list of all converters [is available here](04-converters.md). |
| **condition** | N | `''` | A PHP expression that must evaluate to `true` or `false`. The value is converted if the expression returns `true`. |
| **parameters** | N | `{}` | e.g. `min` and `max` for `numberBetween`. Most converters don't accept any parameter. |
| **unique** | N | `false` | Whether to generate only unique values. May result in a fatal error with converters that can't generate enough unique values. |
| **cache_key** | N | `''` | The generated value will be used by all converters that use this cache key. |
| **disabled** | N | `false` | Can be used to disable a converter declared in a parent config file. |

How to use parameters:

```yaml
tables:
    my_table:
        converters:
            my_column:
                converter: 'randomizeEmail'
                parameters: {domains: ['example.org']}
```

How to define a condition:

```yaml
tables:
    my_table:
        converters:
            my_column:
                converter: 'randomizeEmail'
                condition: '{{another_column}} !== null'
```

The filter is a PHP expression.
Variables must be encapsed by double brackets.


The available variables are the columns of the table.
For example, if the table has a `id` column, the `{{id}}` variable will be available.

### Sharing Converter Results

The `cache_key` parameter can be used to share values between converters.

For example, to generate the same anonymized email in two tables:

```yaml
tables:
    customer_entity:
        converters:
            email:
                converter: 'randomizeEmail'
                cache_key: 'customer_email'
                unique: true
```

```yaml
tables:
    newsletter_subscriber:
        converters:
            subscriber_email:
                converter: 'randomizeEmail'
                cache_key: 'customer_email'
                unique: true
```

Notes:

- If you use the `unique` parameter, it must be specified in all converters that share the same cache key.
  If the parameter is missing somewhere, it can result in a infinite loop situation.
- This feature is not used in the default templates (`magento2`, ...), because it may require a lot of memory, depending on the size of the tables.

### Version-specific Configuration

The `if_version` property allows to define configuration that will be read only if the version of your application matches a requirement.

Syntax:

```yaml
if_version:
    '<2.2':
        # version-specific config here (e.g. tables)
```

The application version can be defined with the `version` parameter, as explained earlier in this documentation.

The `version` parameter becomes mandatory if the `requiresVersion` parameter is defined and set to `true`.
The [magento2 template](config/templates/magento2.yaml) uses that feature.

There is little point to use this feature in your custom configuration file(s).
It is mainly used to provide default config templates that are compatible with all versions of a framework.