require 'roda'
require "sequel"
require_relative 'models/company'

DB = Sequel.connect("jdbc:postgresql://172.17.0.3/new_ecratum?user=postgres&password=postgres")

class App < Roda

  plugin :default_headers,
         'Content-Type'=>'text/html',
         'Content-Security-Policy'=>"default-src 'self' https://oss.maxcdn.com/ https://maxcdn.bootstrapcdn.com https://ajax.googleapis.com",
         #'Strict-Transport-Security'=>'max-age=16070400;', # Uncomment if only allowing https:// access
         'X-Frame-Options'=>'deny',
         'X-Content-Type-Options'=>'nosniff',
         'X-XSS-Protection'=>'1; mode=block'

  use Rack::Session::Cookie,
      :key => '_App_session',
      #:secure=>!TEST_MODE, # Uncomment if only allowing https:// access
      :secret=>"fooo"

  #plugin :csrf
  #plugin :render, :escape=>true
  plugin :json

  route do |r|
    r.root do
      Company.all
    end
  end
end
