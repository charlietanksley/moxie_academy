require 'spec_helper'

describe "Discussion Model" do
  let(:discussion) { Discussion.new }
  it 'can be created' do
    discussion.should_not be_nil
  end
end
