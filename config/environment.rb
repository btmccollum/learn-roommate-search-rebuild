require 'bundler'
Bundler.require

require 'open-uri'

DB = {:conn => SQLite3::Database.new("db/rooms-development.sqlite")}

require_all 'lib'