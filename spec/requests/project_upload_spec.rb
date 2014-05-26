require 'spec_helper'

describe "Project Upload" do

  it "is not exposed without authentication" do
    get '/users/2/upload'
    response.status.should eq(401)
  end

  it "'/upload' should return success" do
    student = FactoryGirl.create(:student)

    login_as student
    get "/users/#{student.id}/upload"

    response.status.should eq(200)
  end

  it "should contain Upload File Button" do
    student = FactoryGirl.create(:student)

    login_as student
    visit user_upload_path(:user_id => student.id)

    page.should have_button("Upload File")
  end

  it "can attach a file" do
    student = FactoryGirl.create(:student)

    login_as student
    visit user_upload_path(:user_id => student.id)
    attach_file "project_document", (Rails.root + "spec/fixtures/test.doc")
    click_button "Upload File"

    page.should have_content("Successfully uploaded project")
  end


  it "should have a list of all projects" do
    projects = FactoryGirl.create_list(:project, 10)
    student = FactoryGirl.create(:student, :projects => projects)

    login_as student
    visit user_projects_path(:user_id => student.id)

    projects.each do |project|
      page.should have_link(project.document_file_name)
    end
  end

  it "can download files" do
    project = FactoryGirl.create(:project)
    student = FactoryGirl.create(:student, :projects => [project])

    login_as student
    get user_project_path(student, project)

    response.should be_success
  end

end

