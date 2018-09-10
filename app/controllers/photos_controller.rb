class PhotosController < ApplicationController
  def index
    if current_user
      @photos = current_user.photos.order(created_at: :desc)
    else
      redirect_to login_path
    end
  end
end