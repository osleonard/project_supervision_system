require 'spec_helper'

describe "UserPages" do
    subject { page } 

    context "profile page" do
        let (:user) { FactoryGirl.create(:user) }
        before { visit user_path(user) }
        it { should have_content(user.name) }
        it { should have_title(user.name) }    
    end

    describe  "signup page" do
        before {visit signup_path}
        it {should have_content('Sign up')}
        it {should have_title(full_title('Sign up'))}
    end
    let(:submit) { "Create my account" }

    context "with invalid information " do
        it "should not create a user" do
            expect { click_button submit }.not_to change(User, :count)
        end
    end

    context "with valid information" do
        before do 
            fill_in "Name", with: "Akinmolayan Olushola"
            fill_in "Matric_no", with: "auo/11/794"
            fill_in "Email", with: "lakinmolayan@gmail.com"
            fill_in "Password", with: "passw0rd"
            fill_in "Confirmation", with: "passw0rd"
        end

        it "should create a user" do 
            expect {click_button submit}.to Change(User, :count).by(1)
        end
    end
end
