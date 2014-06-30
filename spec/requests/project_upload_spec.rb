require 'spec_helper'

describe "Project Upload" do

  it "is not exposed without authentication" do
    get '/users/2/upload'
    response.code.should eq "302"
    response.should redirect_to(root_path)
  end

  describe "#new" do
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
  end


  describe "#create" do
    it "student can attach a file" do
      student = FactoryGirl.create(:student)

      login_as student
      visit user_upload_path(:user_id => student.id)
      project = FactoryGirl.create(:project)
      attach_file "project_document", project.document.path
      click_button "Upload File"

      page.should have_content("Successfully uploaded project")
    end

    it "student owns the projects they attach" do
      student = FactoryGirl.create(:student)
      project = FactoryGirl.create(:project)

      login_as student
      visit user_upload_path(:user_id => student.id)
      attach_file "project_document", project.document.path
      click_button "Upload File"

      page.should have_content("Successfully uploaded project")
      student.projects.map(&:document_file_name).should include(project.document_file_name)
    end

    it "allows only students to upload files" do
      lecturer = FactoryGirl.create(:lecturer)
      project = FactoryGirl.create(:project)

      login_as lecturer
      post user_projects_path(lecturer), :project => {:document => fixture_file_upload(project.document.path)}, :multipart => true

      response.code.should eq "302"
      response.should redirect_to(root_path)
    end
  end

  describe "#index" do

    it "lists projects" do
      projects = FactoryGirl.create_list(:project, 10)
      student = FactoryGirl.create(:student, :projects => projects)

      login_as student
      visit user_projects_path(:user_id => student.id)

      projects.each do |project|
        page.should have_link(project.document_file_name)
      end
    end
  end

  describe "#show" do
    it "can download files" do
      project = FactoryGirl.create(:project)
      student = FactoryGirl.create(:student, :projects => [project])

      login_as student
      get user_project_path(student, project), :format => :txt

      response.should be_success
      response.headers["Content-Disposition"].should eq("attachment; filename=\"#{project.document_file_name}\"")
    end

    it "allows lecturer view projects of students they supervise" do
      lecturer = FactoryGirl.create(:lecturer)
      student = FactoryGirl.create(:student, :lecturer => lecturer)
      project = FactoryGirl.create(:project, :student => student)

      login_as lecturer
      get user_project_path(student, project)

      response.status.should eq(200)
    end


    it "renders files when request type is html" do
      project = FactoryGirl.create(:project)
      file_content = File.read(project.document.path)
      student = FactoryGirl.create(:student, :projects => [project])

      login_as student
      get user_project_path(student, project), :format => :html

      response.should be_success
      response.body.should match(file_content)
    end
  end


  describe "#update" do
    it "student can update their projects" do
      project = FactoryGirl.create(:project)
      student = FactoryGirl.create(:student, :projects => [project])

      login_as student
      put user_project_path(student, project), :format => :html, :project => {:document => "My new content"}

      File.read(project.reload.document.path).should eq "My new content"
    end
    it "lectuers can update projects of their students" do
      project = FactoryGirl.create(:project)
      student = FactoryGirl.create(:student, :projects => [project])
      lecturer = FactoryGirl.create(:lecturer, :students => [student])

      login_as lecturer
      put user_project_path(student, project), :format => :html, :project => {:document => "My new content"}

      File.read(project.reload.document.path).should eq "My new content"
    end
  end

end

