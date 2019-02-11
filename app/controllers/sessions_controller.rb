class SessionsController < ApplicationController
  def new
    @session = Session.new
  end

  def create
    @session = Session.new(session_params)

    if @session.valid?
      user = User.find_by(username: params[:session][:username])

      if user && user.authenticate(params[:session][:password])
        reset_session
        session[:user_id] = user.id

        redirect_to photos_path
      else
        flash.now[:error] = "入力されたユーザー名やパスワードが正しくありません。" + 
                            "確認してからやりなおしてください。"

        render :new
      end
    else
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    reset_session

    redirect_to root_path
  end

  private

  def session_params
    params.require(:session).permit(:username, :password)
  end
end