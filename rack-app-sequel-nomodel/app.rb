require 'bundler'
require 'json'
Bundler.require
Loader.autoload

DB = Sequel.connect \
  '%<adapter>s://%<host>s/%<database>s' % {
    adapter: RUBY_PLATFORM == 'java' ? 'jdbc:postgresql' : 'postgresql',
    host: 'localhost',
    database: 'bm_test'
  },
  max_connections: (ENV['MAX_THREADS'] || 10).to_i,
  pool_timeout: 5

class App < Rack::App
  get '/' do
    JSON.fast_generate DB['select id, name from companies limit 100'].entries
  end
end
