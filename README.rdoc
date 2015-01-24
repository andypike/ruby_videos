Ruby Videos
===========

A curated listing of quality videos about or related to the Ruby programming
language.

Setup
-----

```
git clone git@github.com:andypike/ruby_videos.git
cd ruby_videos
cp config/example.database.yml config/database.yml
psql postgres
# create user ruby_videos with password '' CREATEDB;
# \q
bundle
rake db:create db:migrate db:seed
rake db:create db:migrate RAILS_ENV=test
rails s
```
