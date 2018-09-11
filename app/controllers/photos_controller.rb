class PhotosController < ApplicationController
  def index
    if current_user
      @photos = current_user.photos.order(created_at: :desc)
    else
      redirect_to login_path
    end
  end

  def new
    if current_user
      @photo = Photo.new
    else
      redirect_to login_path
    end
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
end