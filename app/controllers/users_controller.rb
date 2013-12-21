class UsersController < ApplicationController
  before_filter :authorize, :only => [:show, :index]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      login!
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @public_goals = @user.goals.where(:is_private => "false")
    @private_goals = @user.goals.where(:is_private => "true")
    render :show
  end

  def index
    @users = User.all
    render :index
  end
end
