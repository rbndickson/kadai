class OAuthController < ApplicationController
  def receive_code
    auth_code = params[:code]

    redirect_to photos_path
  end
end