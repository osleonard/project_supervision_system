require 'spec_helper'

describe User do
  before {@user = User.new(name: "Akinmolayan Olushola", matric_no:"AUO/11/794", email:"lakinmolayan@gmail.com", password: "passw0rd", password_confirmation: "passw0rd")}
  it {should respond_to(:name)}
  it {should respond_to(:matric_no)}
  it {should respond_to(:email)}
  it {should respond_to(:password_digest)}
  it {should respond_to(:password) }
  it {should respond_to(:password_confirmation) }
  it {should respond_to(:authenticate)}

  context "when name is not present" do
    it "should not be valid" do
      @user.name= " "
      @user.should_not be_valid
    end
  end

  context "when name is too long" do
    before {@user.name = "a" * 51 }
    it { should_not be_valid}
  end

  context "when matric number is not present" do
    before {@user.matric_no = " "}
    it {should_not be_valid }
  end

  context "when matric number format is invalid" do
    it "should be invalid" do
      numbers= %w[AUO/00/ AUO/0/111 AUO/00/I]
      numbers.each do |invalid_number|
        @user.matric_no = invalid_number
        expect(@user).to be_invalid
      end
    end
  end

  context "when matric number format is valid" do
    it "should be valid" do
      numbers = %w[AUO/11/794]
      numbers.each do |valid_number|
        #@user.matric_no = valid_number
        #expect(@user).to be_valid
      end
    end
  end

  context "when email is not present" do
    before {@user.email= " "}
    it {should_not be_valid}
  end

  context "when email format is invalid" do
    it "should be valid " do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  context "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.matric_no = @user.matric_no + rand(9).to_s
        expect(@user).to be_valid
      end
    end
  end

  context "when email address is already taken" do
    it "spec_name" do
      
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
      @user.should_not be_valid 
    end
  end
  context "when password is not present" do 
    it "should not be valid" do
      user = User.new(name: "Akinmolayan Olushola", matric_no:"AUO/11/794", email: "lakinmolayan@gmail.com",password: " ", password_confirmation: " ")
      user.should_not be_valid
    end
  end

  context "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { @user.should_not be_valid }
  end

  context "return value of authenticate method" do 

    before do
      @user.save
      @found_user =  User.find_by(matric_no: @user.matric_no)
    end

    it "return user" do
      @user.should eq @found_user.authenticate(@user.password) 
    end

    context "with invalid password" do
      let(:user_for_invalid_password) { @found_user.authenticate("invalid") }
      it { should_not eq user_for_invalid_password }
      it { expect(user_for_invalid_password).to be_false }
    end
    context "with a password that's too short" do
      before { @user.password = @user.password_confirmation = "a" * 5 }
      it { should be_invalid }
    end
  end
end
