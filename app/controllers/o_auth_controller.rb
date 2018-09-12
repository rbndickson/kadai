require 'net/http'

class OAuthController < ApplicationController
  def callback
    token = exchange_code_for_token(params[:code])

    session[:access_token] = token

    redirect_to photos_path
  end

  private

  def exchange_code_for_token(code)
    uri = URI(MyTweet.token_request_url)

    req = Net::HTTP::Post.new(uri)
    req.set_form_data('code' => code,
                      'client_id' => MyTweet.client_id,
                      'client_secret' => MyTweet.client_secret,
                      'response_type' => 'token',
                      'redirect_uri' => 'http://localhost:3000/oauth/callback',
                      'grant_type' => 'authorization_code')
    
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == 'https')
    res = http.request(req)

    body = JSON.parse(res.body)

    body['access_token']
  end
end