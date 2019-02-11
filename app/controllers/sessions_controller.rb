class SessionsController < ApplicationController
  def new
  end

  def create
    if params[:username].blank? || params[:password].blank?
      if params[:username].blank?
        flash.now[:missing_username] = "ユーザーIDを入力してください"
      end

      if params[:password].blank?
        flash.now[:missing_password] = "パスワードを入力してください"
      end

      render :new
    else
      user = User.find_by(username: params[:username])

      if user && user.authenticate(params[:password])
        reset_session
        session[:user_id] = user.id

        redirect_to photos_path
      else
        flash.now[:error] = "入力されたユーザー名やパスワードが正しくありません。" + 
                            "確認してからやりなおしてください。"

        render :new
      end
    end
  end

  def destroy
    session[:user_id] = nil
    reset_session

    redirect_to root_path
  end
end