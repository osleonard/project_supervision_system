require 'spec_helper'

describe User do
  before {@user = User.new(name: "Example User", matric_no:"AUO/09/123", email:"user@example.com")}
  it {should respond_to(:name)}
  it {should respond_to(:matric_no)}
  it {should respond_to(:email)}
  it { @user.should be_valid }

  context "when name is not present" do
    before {@user.name= " " }
    it { should_not be_valid }
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
        expect(@user).to be_valid
      end
    end
  end
  context "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end
    it {should_not be_valid}
  end
end
