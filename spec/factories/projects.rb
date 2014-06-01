FactoryGirl.define do
  factory :project do
    document File.open(Rails.root + "spec/fixtures/test.txt")
  end
end
