class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(*params[:user].values)
    if @user
      login!
      redirect_to goals_url
    else
      flash.now[:errors] = ["Invalid username/password"]
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.reset_session_token!
    session[:token] = nil
    redirect new_session_url
  end
end
