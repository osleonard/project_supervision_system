require 'spec_helper'

describe Project do
  it "should belong to user" do
    p = Project.reflect_on_association(:user)
    expect(p.macro).to eq(:belongs_to)
  end
end
