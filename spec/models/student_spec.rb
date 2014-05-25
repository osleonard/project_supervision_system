require 'spec_helper'

describe Student do
  before do
    @student = FactoryGirl.create(:student)
  end

  it {should respond_to(:matric_no)}

  context "relationship with lecturer" do
    it "should be 'belongs_to'" do
      u = Student.reflect_on_association(:lecturer)
      expect(u.macro).to eq(:belongs_to)
    end
  end

  it do
    @student.matric_no = " "
    should_not be_valid
  end

  it "when matric number format is valid student should be valid" do
    numbers = %w[AUO/11/794 AUO/11/795]
    numbers.each do |valid_number|
      @student.matric_no = valid_number
      expect(@student).to be_valid
    end
  end

  it "when matric number format is invalid" do
    numbers= %w[AUO/00/ AUO/0/111 AUO/00/I]
    numbers.each do |invalid_number|
      @student.matric_no = invalid_number
      expect(@student).to be_invalid
    end
  end

  it "authenticates students when a correct password is supplied" do
      found_student =  Student.find_by(matric_no: @student.matric_no)
      @student.should == found_student.authenticate(@student.password)
  end

  it "does not authenticate when an invalid password is supplied" do
    found_student =  Student.find_by(matric_no: @student.matric_no)
    expect(found_student.authenticate("invalid")).to be_false
  end

  it  "invalidates short passwords" do
    @student.password = @student.password_confirmation = "a" * 5
    should be_invalid
  end

  context "relationship with projects" do
    it "should be 'has_many'" do
      u = Student.reflect_on_association(:projects)
      expect(u.macro).to eq(:has_many)
    end

    it "should be able to create 'projects'" do
      @student.projects << FactoryGirl.create(:project)
      @student.save
      @student.reload
      expect(@student.projects.size).to eq(1)
    end
  end

end
