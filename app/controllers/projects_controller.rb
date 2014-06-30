class ProjectsController < ApplicationController
  before_filter :get_user

  def index
    @projects = @user.projects

  end

  def edit
    @project = Project.find(params[:id])
    @file = File.read(@project.document.path)
  end

  def update
    @project = Project.find(params[:id])
    Rails.logger.info params
    File.write(@project.document.path, params[:project][:document])
    redirect_to user_project_path(@user, @project, :format => "html")
  end

  def new
    @project = Project.new
  end

  def show
    @project = Project.find(params[:id])
    if @project.try(:document).present? and params[:format] == "html"
      @file = File.read(@project.document.path)
    elsif @project.try(:document).present?
      send_file @project.document.path, :filename => @project.document_file_name,:content_type => @project.document_content_type
    else
      redirect_to user_path(current_user)
    end
  end

  def create
    @project = Project.new(file_params)
    return redirect_to(root_path) unless current_user.is_a?(Student)
    @project.student = current_user
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

    redirect_to root_path unless (@user.present? && current_user.present? && (@user == current_user || @user.lecturer = current_user))
  end
end
