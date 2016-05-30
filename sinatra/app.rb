require 'sinatra'
require 'sinatra/json'
require 'json'
require 'active_record'


get '/' do
  conn = PG.connect(dbname: 'ecratum', user:'postgres', password:'postgres', host:'172.17.0.3')
  results = conn.exec('SELECT id, name from companies LIMIT 100')
  results.map do |row|
    { 
      id: row.values_at('id').first, 
      name: row.values_at('name').first
    }
   end.to_json
end
