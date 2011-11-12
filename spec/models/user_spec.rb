require 'spec_helper'

describe "User Model" do
  it 'can be created' do
    user = User.new
    user.should_not be_nil
  end

  # it 'can be saved' do
  #   g = Group.new(:password => 'this')
  #   u = User.new(:email => 'yes@email.com', :group_id => g.id)
  #   u.save

  #   b = User.first(:email => 'yes@email.com')
  #   b.group_id.should == g.id
  #end

  it 'is valid if all the parts are in place' do
    user = build :user
    user.should be_valid
  end

  it 'is invalid without email' do
    user = build(:user, :email => '')
    user.should_not be_valid
  end

  it 'is invalid without group_id' do
    user = build(:user, :group_id => '')
    user.should_not be_valid
  end

  it 'is invalid without a name' do
    user = build(:user, :name => '')
    user.should_not be_valid
  end

  pending 'belongs to a group'

end
