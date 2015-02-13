class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def create
  end

  def show

  end

  def new
    @user = User.new
    render :new
  end

  def destroy
  end

private

  def user_params
  end

end
