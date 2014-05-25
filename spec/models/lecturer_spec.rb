require 'spec_helper'

describe Lecturer do
  context "relationship with students" do
    it "should be 'has_many'" do
      lectuer = Lecturer.reflect_on_association(:students)
      expect(lectuer.macro).to eq(:has_many)
    end

    it "should be own students" do
      lecturer = FactoryGirl.create(:lecturer)
      lecturer.students << FactoryGirl.create(:student)
      lecturer.save
      lecturer.reload
      expect(lecturer.students.size).to eq(1)
    end
  end
end
