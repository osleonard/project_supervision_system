require 'spec_helper'


describe "File Upload" do

  it "'/upload' should return sucess" do 
    get '/upload'
    response.status.should eq(200)
  end

  it "should contain a form" do
    visit upload_path
    page.should has_field("File")
  end
end

