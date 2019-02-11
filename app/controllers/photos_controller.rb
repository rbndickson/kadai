class PhotosController < ApplicationController
  before_action :require_user, only: [:index, :new]

  def index
    @photos = current_user.photos.order(created_at: :desc)
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.user_id = current_user.id

    title = params[:photo][:title]
    image = params[:photo][:image]

    if @photo.valid? && !image.nil?
      @photo.save!

      redirect_to photos_path
    else
      flash.now[:image_missing] = "画像ファイルを入力してください" if image.nil?

      render :new
    end
  end

  def tweet
    photo = Photo.find(params[:photo_id])
    MyTweet.tweet(session[:access_token], photo.title, url_for(photo.image))

    redirect_to photos_path
  end

  private

  def photo_params
    params.require(:photo).permit(:title, :image)
  end

  def require_user
    redirect_to login_path unless current_user
  end
end