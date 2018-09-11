# To add credentials:
# EDITOR=vim rails credentials:edit

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
end