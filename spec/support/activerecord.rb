if RUBY_ENGINE == 'jruby'
  require 'activerecord-jdbcpostgresql-adapter'
else
  require 'pg'
end
require 'active_record'
require 'imagizer_engine/orm/activerecord'
Bundler.require

# Change this if PG is unavailable
dbconfig = {
  :adapter  => 'postgresql',
  :database => 'imagizer_engine_test',
  :encoding => 'utf8'
}

database = dbconfig.delete(:database)

ActiveRecord::Base.establish_connection(dbconfig.merge(database: "template1"))
begin
  ActiveRecord::Base.connection.create_database database
rescue ActiveRecord::StatementInvalid => e # database already exists
end
ActiveRecord::Base.establish_connection(dbconfig.merge(:database => database))

ActiveRecord::Migration.verbose = false

if ActiveRecord::VERSION::STRING >= '4.2'
  ActiveRecord::Base.raise_in_transactional_callbacks = true
end
