require 'spec_helper'

describe "Group Model" do

  it 'can be created' do
    group = Group.new 
    group.should_not be_nil
  end

  it 'succeeds if all the parts are in place' do
    group = build :group
    group.should be_valid
  end

  it 'creation fails without a password' do
    group = build :group, :password => ''
    group.should_not be_valid
  end

  it 'creation fails if the password is not unique' do
    g1 = create :group
    group = build :group, :password => g1.password
    group.should_not be_valid
  end

  pending 'has many users' 

end
