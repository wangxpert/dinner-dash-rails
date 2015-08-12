class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome #{user_params[:first_name]} to dinner dash!"
      redirect_to root_path
    else
      flash[:error] = "One or more required fields are missing"
      render "new"
    end
  end

  def show
    @user = User.find(params[:id])
    @orders = @user.orders
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
