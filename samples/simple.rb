require 'sinatra'
require 'sinatra/json'

class SimpleEndpoint  < Sinatra::Base
  helpers Sinatra::JSON

  post '/order' do
    message = JSON.parse(request.body.read).symbolize_keys

    json 'message_id' => message[:message_id]
  end

end
