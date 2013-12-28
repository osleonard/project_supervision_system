require 'spec_helper'

describe "StaticPages" do
    let(:base_title) {"Welcome To Online Supervision App"}
  describe "Home page" do
    
      it "should have the right title" do
          visit '/static_pages/home'
            expect(page).to have_title("#{base_title} | Home")
    end
    
      it "should have the content 'Welcome To Online Supervision App'" do
       visit '/static_pages/home/'
      expect(page).to have_content('Welcome To Online Supervision App')
    end
  end 
  
describe "Contact" do

    it "should have the content 'Welcome To Online Collaboration App'" do
      visit '/static_pages/contact/'
      expect(page).to have_content('Contact')
    end

   it "should have the right title" do
          visit '/static_pages/contact'
            expect(page).to have_title("#{base_title} | Contact")
    end
  end

describe "Register" do
    
    it "should have the content 'Welcome To Online Collaboration App'" do
      visit '/static_pages/register/'
      expect(page).to have_content('Registration')
    end

    it "should have the right title" do
          visit '/static_pages/register'
            expect(page).to have_title("#{base_title} | Register")
    end
  end
 end
