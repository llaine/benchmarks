require 'bundler'
require 'json'
Bundler.require
Loader.autoload

Sequel.connect \
  '%<adapter>s://%<host>s/%<database>s' % {
    adapter: RUBY_PLATFORM == 'java' ? 'jdbc:postgresql' : 'postgresql',
    host: 'localhost',
    database: 'bm_test'
  },
  max_connections: (ENV['MAX_THREADS'] || 10).to_i,
  pool_timeout: 5

Sequel::Model.plugin :json_serializer

class Company < Sequel::Model(:companies); end

class App < Rack::App
  get '/' do
    Company.select(:id, :name).limit(100).to_json
  end
end
