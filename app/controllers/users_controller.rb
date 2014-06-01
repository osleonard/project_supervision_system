class UsersController < ApplicationController
  def index
    @users = User.paginate(page: params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash.now[:notice] = 'You have successfully updated you profile'
      redirect_to @user
    else
      render 'edit'
    end
  end

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
