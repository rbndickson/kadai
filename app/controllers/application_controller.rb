class ApplicationController < ActionController::Base
  helper_method :user_logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_logged_in?
    !!current_user
  end
end
