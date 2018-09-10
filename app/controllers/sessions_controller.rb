class SessionsController < ApplicationController
  def new
  end

  def create
    if params[:username].blank? || params[:password].blank?
      flash.now[:missing_username] = "ユーザーIDが未入力" if params[:username].blank?
      flash.now[:missing_password] = "パスワードが未入力" if params[:password].blank?

      render :new
    else
      user = User.find_by(username: params[:username])

      if user && user.authenticate(params[:password])
        session[:user_id] = user.id

        redirect_to root_path
      else
        flash.now[:error] = "ユーザーIDとパスワードが一致するユーザーが存在しない"

        render :new
      end
    end
  end
end