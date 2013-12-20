module SessionsHelper
  def login!
    session[:token] = @user.reset_session_token!
  end

  def current_user
    User.find_by_session_token(session[:token])
  end

  def logged_in?
    !!current_user
  end

  def authorize
    redirect_to new_session_url unless logged_in?
  end
end
