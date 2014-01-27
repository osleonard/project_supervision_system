class FileUploadController < ApplicationController

  def new
    @file_upload = Fileupload.new
  end

  def create
    @file_upload = Fileupload.create(file_params)
  end

  private

  def file_params
    params.require(:file_upload).permit(:document)
  end
end
