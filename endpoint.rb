# bundle exec rackup -s thin -p 9000
require 'sinatra'
require 'sinatra/json'
require 'httparty'
require 'json'
require 'socket'

class DemoEndpoint  < Sinatra::Base
  helpers Sinatra::JSON
  set :logging, true

  configure do
    set :registered, nil
    set :message, nil
  end

  get '/' do
    erb :index
  end

  post '/register' do
    name = params[:name]
    name.gsub!(/[^a-zA-Z]/, '.')
    name.downcase!

    response = HTTParty.post("http://bdq.spreeconf.com:8000/api/registrations.json",
                         body: { registration: { keys: ['order:new'], url: "http://#{params[:ip]}:9000/order", name: name, token: 'abc123' }},
                         headers: { 'token' => 'VapTLtybjAp9qCs4gUJv', 'store' => '5180e2507575e48dd0000001'} )

    if response.key? 'name'
      settings.registered = response.to_hash
      redirect to('/')
    else
      'Failed to create registration.'
    end
  end

  post '/order' do
    logger.error "---- Incoming Message"
    settings.message = JSON.parse(request.body.read).symbolize_keys

    json({'message_id' => settings.message[:message_id],
          'my_name' => settings.registered['name'] })
  end

end
