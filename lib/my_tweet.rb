# To add credentials:
# EDITOR=vim rails credentials:edit
require 'net/http'

module MyTweet
  def self.client_id
    Rails.application.credentials.my_tweet[:client_id]
  end

  def self.client_secret
    Rails.application.credentials.my_tweet[:client_secret]
  end

  def self.code_request_url
    "https://arcane-ravine-29792.herokuapp.com/oauth/authorize" +
    "?redirect_uri=http://localhost:3000/oauth/callback" +
    "&response_type=code" +
    "&client_id=#{client_id}"
  end

  def self.token_request_url
    "https://arcane-ravine-29792.herokuapp.com/oauth/token"
  end

  def self.tweet(token, text, url)
    my_tweet_api_url = "https://arcane-ravine-29792.herokuapp.com/api/tweets"

    uri = URI(my_tweet_api_url)

    req = Net::HTTP::Post.new(uri)

    req.set_form_data('text' => text, 'url' => url)

    # Set header
    req['Authorization'] = "Bearer #{token}"
    
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == 'https')

    res = http.request(req)
  end
end