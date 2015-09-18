class UsersController < ApplicationController

  def update
    if current_user.update_attributes(user_params)
      flash[:notice] = "User updated"
    else
      flash[:error] = "Something went wrong"
    end
    redirect_to root_path
  end

  private

  def user_params
    params.requre(:user).permit(:name, :email, :passwor)
  end
end
