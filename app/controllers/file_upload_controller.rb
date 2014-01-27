def create
  @user = User.create (params[:users])
end

private

def user_params
  param.require(:user).permit(:document_avatar)
end
