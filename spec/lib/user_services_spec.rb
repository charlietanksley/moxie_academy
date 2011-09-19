require 'spec_helper'
require 'user_services'


class TestUser
  include UserServices::Authentication

  attr_reader :id

  def initialize(*id)
    @id = id
  end

end

describe UserServices::Authentication do

  describe '#logged_in?' do
    it 'calls the current_user method' do
      t = TestUser.new
      t.should_receive(:current_user)#.with("password").and_return(true)
      
      t.logged_in?
    end

    it 'returns true if current_user is not nil' do
      t = TestUser.new
      t.stub!(:current_user) { Object.new }
      
      t.logged_in?.should be_true
    end

    it 'returns false if current_user is nil' do
      t = TestUser.new
      t.stub!(:current_user) { nil }
      
      t.logged_in?.should be_false
    end
  end

  describe '#set_current_user' do
    before :each do
      @user = TestUser.new(12)
    end

    it 'takes a user as an argument and sets the session_id as their id' do
      @user.set_as_current_user

    end
  end

  
end
