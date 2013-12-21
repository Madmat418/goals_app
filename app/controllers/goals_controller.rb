class GoalsController < ApplicationController
  def create
    params[:goal][:user_id] = current_user.id
    @goal = Goal.new(params[:goal])
    if @goal.save
      redirect_to user_url(current_user)
    else
      flash.now[:errors] = @goal.errors.full_messages
      redirect_to user_url(current_user)
    end
  end
end
