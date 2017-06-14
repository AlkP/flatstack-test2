class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_access!
  before_action :set_user, only: [:edit, :update]
  
  def update
    if @user.update(users_params)
      redirect_to events_path
    else
      flash[:danger] = @user.errors.full_messages.to_sentence
      render 'edit'
    end
  end
  
  private
  
  def users_params
    params.require(:user).permit(:email, :password, :initials)
  end
  
  def check_access!
    return true if "#{current_user.id}" == "#{params[:id]}"
    flash[:danger] = t('.access_error')
    redirect_to events_path 
  end
  
  def set_user
    @user = User.find(params[:id])
  end
end
