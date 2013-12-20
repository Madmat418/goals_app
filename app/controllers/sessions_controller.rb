class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(*params[:user].values)
    if @user
      login!
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ["Invalid username/password"]
      render :new
    end
  end

  def destroy
    @user = current_user
    @user.reset_session_token!
    session[:token] = nil
    redirect_to new_session_url
  end
end
