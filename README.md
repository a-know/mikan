## mikan's - 未完ズ -

![build status](https://circleci.com/gh/a-know/mikan.svg?style=shield&circle-token=d37f7eee9f9906240a8b6b386315ff20ac6e86dd)

### Prepare
#### Install PostgreSQL
```sh
$ brew install postgresql
```

#### Prepare for database
```sh
$ psql -d postgres
postgres=# create role mikan login createdb;
postgres=# \q
$ rake db:create
$ rake db:migrate
```

#### Install `PhantomJS`
```sh
$ brew install phantomjs
```
