module ApplicationHelper
  def user_signed_in?
    !!session[:id]
  end

  def current_user
    session[:id]
  end
end
