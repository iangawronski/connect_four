class UsersController < ApplicationController

  def index
    @users = User.all
  end

  # def create
  # end

  def show
    @user = current_user
    render :show
  end

  def new
    @user = User.new
    render :new
  end

  def destroy
    @user = current_user
    if current_user && current_user == @user
      @user.destroy
      redirect_to edit_user_registration_path, notice: "Your Four Square account has succesfully been deleted."
    else
      flash[:alert] = "You can only delete your account!"
      redirect_to :root
    end
  end

private

  def user_params
  end

end
