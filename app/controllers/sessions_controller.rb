class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(matric_no: params[:session][:matric_no].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:id] = user.id
      redirect_to user_path(user)
    else
      flash.now[:error] = 'Invalid matricnumber/password combination'
      render 'new'
    end
  end

  def destroy
    session[:id] = nil
    redirect_to root_path
  end

end
