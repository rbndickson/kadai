class SessionsController < ApplicationController
  def new
  end

  def create
    if params[:username].blank? || params[:password].blank?
      flash.now[:missing_username] = "ユーザーIDを入力してください" if params[:username].blank?
      flash.now[:missing_password] = "パスワードを入力してください" if params[:password].blank?

      render :new
    else
      user = User.find_by(username: params[:username])

      if user && user.authenticate(params[:password])
        session[:user_id] = user.id

        redirect_to photos_path
      else
        flash.now[:error] = "入力されたユーザー名やパスワードが正しくありません。確認してからやりなおしてください。"

        render :new
      end
    end
  end

  def destroy
    session[:user_id] = nil

    redirect_to root_path
  end
end