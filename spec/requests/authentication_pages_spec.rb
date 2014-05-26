require 'spec_helper'

describe "AuthenticationPages" do
  subject {page}

  describe "Sign in page" do
    before {visit signin_path}
    it { page.should have_selector('h1', text: 'Sign in') }
    it { page.should have_title('Sign in') }
  end

  context "signin" do
    before {visit signin_path}

    context "with invalid information" do
      before { click_button "Sign in" }
      it { page.should have_title('Sign in') }
      it { page.should have_selector('div.alert-error') }
      context "after visiting another page " do
        before { click_link "Home"}
        it { page.should_not have_selector('div.alert.error') }
      end
    end

    context "with valid information"  do
      let(:student) { FactoryGirl.create(:student) }
      before do
        visit signin_path
        fill_in "session_matric_no", with: student.matric_no
        fill_in "session_password", with: student.password
        click_button "Sign in"
      end

      it { page.should have_title(student.name) }
      it { page.should have_link('Profile', href: user_path(student)) }
      it { page.should have_link('Sign out', href: signout_path) }
      it { page.should_not have_link('Sign in', href: signin_path) }
    end

    it "should allow email login for lecturers" do
      lecturer = FactoryGirl.create(:lecturer)
      visit signin_path
      fill_in "session_matric_no", with: lecturer.email
      fill_in "session_password", with: lecturer.password
      click_button "Sign in"
      page.should have_title(lecturer.name)
    end
  end
end
