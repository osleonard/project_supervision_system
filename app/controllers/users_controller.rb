class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit(:name, :matric_no,:email, :password, :password_confirmation)
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome"
      redirect_to root_path #home page redirection for the moment
    else
      render 'new'
    end
  end
end
