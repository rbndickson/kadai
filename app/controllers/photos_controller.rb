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

    if title.blank? || title.length > 30 || image.nil?
      if title.blank?
        flash.now[:title_missing] = "タイトルを入力してください"
      end

      if image.nil?
        flash.now[:image_missing] = "画像ファイルを入力してください"
      end

      if title.length > 30
        flash.now[:title_long] = "30文字以下のタイトルを入力してください"
      end

      render :new
    else
      @photo.save!

      redirect_to photos_path
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