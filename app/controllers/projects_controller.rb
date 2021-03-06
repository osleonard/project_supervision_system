class ProjectsController < ApplicationController
  before_filter :get_user

  def index
     @projects = @user.projects
  end

  def edit
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def show
    @project = Project.find(params[:id])
    if @project.present?
      redirect_to redirect_to 'projects/1'
    else
      send_file @project.document.path, :filename => @project.document_file_name,:content_type => @project.document_content_type,
                :disposition => 'document', :sendfile => true
      end
  end

  def create
    @project = Project.new(file_params)
    if @project.save
      flash[:success] = "Successfully uploaded project"
      redirect_to user_path(current_user)
    else
      flash.now[:error] = 'Invalid matric_number/password combination'
      render 'new'
    end
  end

  private

  def file_params
    params.require(:project).permit(:document)
  end

  def get_user
    @user = User.find_by(:id => params[:user_id]) if params[:user_id]

    redirect_to root_path, :status => :unauthorized unless (@user.present? && current_user.present? && @user == current_user)
  end
end
