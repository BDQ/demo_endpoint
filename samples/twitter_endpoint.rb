require 'twitter'
require 'sinatra'
require 'sinatra/json'

class SimpleEndpoint  < Sinatra::Base
  helpers Sinatra::JSON

  post '/follow' do
    Twitter.configure do |config|
      config.consumer_key = 'iQ55...'
      config.consumer_secret = 'YQoQ...'
      config.oauth_token = '8213...'
      config.oauth_token_secret = '6Rwn...'
    end

    begin
      Twitter.follow(@msg['payload']['order']['actual']['twitter'])

      process_result 200, { 'message_id' => @msg[:message_id], 
            'following' => Twitter.following.map &:name }
    rescue
      process_result 500,
           { 'username' =>  @msg['payload']['order']['actual']['twitter'] }
    end

  end

end
