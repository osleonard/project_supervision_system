require 'spec_helper'

describe "UserPages" do
  subject { page }

  context "profile page" do
    before do
      @user = FactoryGirl.create(:user)
      visit user_path(@user)
    end
    it { should have_content(@user.name) }
    it { should have_title(@user.name) }
  end

  describe  "signup page" do
    before {visit signup_path}
    it {  page.should have_content('Sign up')}
    it { page.should have_title(full_title('Sign up')) }
  end
  let(:submit) { "Create my account" }

  context "with invalid information " do
    it "should not create a user" do
      visit signup_path
      expect { click_button submit }.not_to change(User, :count)
    end
  end

  it "should create a user" do
    visit signup_path
    fill_in "user_name", with: "Akinmolayan Olushola"
    fill_in "user_matric_no", with: "auo/11/794"
    fill_in "user_email", with: "lakinmolayan@gmail.com"
    fill_in "user_password", with: "passw0rd"
    fill_in "user_password_confirmation", with: "passw0rd"
    expect { click_button submit }.to change{User.count}.by(1)
  end

  it "students should have a route for projects" do
    project = FactoryGirl.create(:project)
    student = FactoryGirl.create(:student, :projects => [project])

    login_as student

    get user_projects_path(student, project)
    response.should be_success
  end

  it "users should be able to upload an own a file" do

  end
end
