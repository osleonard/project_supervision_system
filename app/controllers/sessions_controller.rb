class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(matric_no: params[:session][:matric_no].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to user
    else
      flash.now[:error] = 'Invalid matricnumber/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

  private
  def sign_in user
    session[:id] = user.id
  end

end
