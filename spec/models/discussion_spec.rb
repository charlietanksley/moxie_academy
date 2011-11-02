require 'spec_helper'

describe "Discussion Model" do
  let(:group) { create(:group) }
  let(:discussion) { Discussion.new }
  let(:complete_discussion) { Discussion.new(:group_id => group.id) }

  it 'can be created' do
    discussion.should_not be_nil
  end

  it 'is invalid without group_id' do
    discussion.should_not be_valid
  end

  it 'is valid if it has a group_id' do
    complete_discussion.should be_valid
  end
end
