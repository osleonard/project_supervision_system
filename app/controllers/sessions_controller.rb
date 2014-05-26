class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.where("matric_no = ? OR email = ?", params[:session][:matric_no].downcase, params[:session][:matric_no]).first
    if user && user.authenticate(params[:session][:password])
      session[:id] = user.id
      redirect_to user_path(user)
    else
      flash.now[:error] = 'Invalid (matricnumber/email) or password combination'
      render 'new'
    end
  end

  def destroy
    session[:id] = nil
    redirect_to root_path
  end

end
