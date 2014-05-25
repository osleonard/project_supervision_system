require 'spec_helper'

describe Project do
  it "should belong to student" do
    project = Project.reflect_on_association(:student)
    expect(project.macro).to eq(:belongs_to)
  end
end
