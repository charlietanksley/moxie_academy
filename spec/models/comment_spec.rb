require 'spec_helper'

describe "Comment Model" do
  let(:discussion) { create(:discussion) }
  let(:user) { create(:user) }
  let(:comment) { Comment.new(:user_id => user.id, :discussion_id => discussion.id, :body => 'whatever') }

  it 'can be created' do
    comment.should_not be_nil
  end

  describe 'discussion_id' do
    let(:bald_comment) { Comment.new(:user_id => user.id) }

    it 'fails without a discussion_id' do
      bald_comment.should_not be_valid
    end

    it 'passes with a discussion_id' do
      comment.should be_valid
    end
  end

  describe 'user_id' do
    let(:bald_comment) { Comment.new(:discussion_id => discussion.id) }

    it 'is invalid without user_id' do
      bald_comment.should_not be_valid
    end

    it 'is valid if it has a group_id' do
      comment.should be_valid
    end
  end

  it 'has a created_at timestamp' do
    comment.created_at.should == ''
  end

  pending 'belongs to a user'
end
