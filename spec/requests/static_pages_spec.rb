require 'spec_helper'

describe "StaticPages" do

  describe "Home page" do
    
      it "should have the base title" do
            visit root_path
            expect(page).to have_title("Welcome To Online Supervision App")
    end

    it "should not have custom page title " do
    visit root_path
    expect(page).not_to have_title('| Home')
    end
    
      it "should have h1 'Welcome To Online Supervision App'" do
       visit root_path
      expect(page).to have_content('Welcome To Online Supervision App')
    end
  end 
  
describe "Contact" do

    it "should have h1 'Contact Page' " do
      visit contact_path
      expect(page).to have_content('Contact')
    end

   it "should have the right title 'Contact' " do
          visit contact_path
            expect(page).to have_title("Welcome To Online Supervision App | Contact")
    end
  end

describe "Register" do
    
    it "should have h1 'Signup'" do
      visit register_path 
      expect(page).to have_content('Signup')
    end

    it "should have the right title 'Signup' " do
          visit register_path
            expect(page).to have_title("Welcome To Online Supervision App | Signup")
    end
  end
end

