module ApplicationHelper
  def user_signed_in?
    !!session[:id]
  end

  def current_user
    @current_user ||= User.find_by(:id => session[:id])
  end

  def current_user=(id)
    session[:id] = id
    @current_user = User.find_by(:id => session[:id])
  end

  def sign_in(user)
    session[:id] = user.id
  end
end
