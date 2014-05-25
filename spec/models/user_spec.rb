require 'spec_helper'

describe User do
  before do
    @user = FactoryGirl.create(:user)
  end

  it {should respond_to(:name)}
  it {should respond_to(:email)}
  it {should respond_to(:password_digest)}
  it {should respond_to(:password) }
  it {should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it {should respond_to(:authenticate)}

  it "when name is not present user should not be valid" do
    @user.name= " "
    @user.should_not be_valid
  end

  context "when name is too long" do
    before {@user.name = "a" * 51 }
    it { should_not be_valid}
  end

  it "when email is not present" do
    @user.email= " "
    should_not be_valid
  end

  it "when email format is invalid" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.foo@bar_baz.com foo@bar+baz.com]
    addresses.each do |invalid_address|
      @user.email = invalid_address
      expect(@user).not_to be_valid
    end
  end

  it "when email format is valid user should be valid" do
    addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
    addresses.each do |valid_address|
      @user.email = valid_address
      expect(@user).to be_valid
    end
  end

  it "when email address is already taken" do
    user_with_same_email = @user.dup
    user_with_same_email.email = @user.email.upcase
    user_with_same_email.save
    user_with_same_email.should_not be_valid
  end

  it "when password is not present user should not be valid" do
    user = User.new(name: "Akinmolayan Olushola", email: "lakinmolayan@gmail.com",password: " ", password_confirmation: " ")
    user.should_not be_valid
  end

  it "when password doesn't match confirmation" do
    @user.password_confirmation = "mismatch"
    @user.should_not be_valid
  end

end
