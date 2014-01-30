require 'spec_helper'

describe "Project Upload" do

  it "'/upload' should return sucess" do 
    get '/upload'
    response.status.should eq(200)
  end

  it "should contain Upload File Button" do
    visit upload_path
    page.should have_button("Upload File")
  end

  it "can attach a file" do
    visit upload_path
    attach_file "project_document", (Rails.root + "spec/fixtures/test.doc")
    click_button "Upload File"
    page.should have_content("Successfully uploaded project")
  end


  it "should have a list of all projects" do
    FactoryGirl.create_list(:project, 10)
    visit projects_path
    page.should have_link("test.doc")
  end

  it "can download files" do
    @project = FactoryGirl.build(:project)
    @project.save
    get project_path(@project)
    response.should be_success
  end

end

