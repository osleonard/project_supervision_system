class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def show
    @project = Project.find(params[:id])
    send_file @project.document.path, :filename => @project.document_file_name,:content_type => @project.document_content_type
  end

  def create
    @project = Project.new(file_params)
    if @project.save
      redirect_to root_url
    else
      flash.now[:error] = 'Invalid matricnumber/password combination'
      render 'new'
    end
  end

  private

  def file_params
    params.require(:project).permit(:document)
  end
end
