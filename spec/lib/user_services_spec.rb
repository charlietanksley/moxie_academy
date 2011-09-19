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
    it 'calls the session_id method' do
      t = TestUser.new
      t.should_receive(:session_id)#.with("password").and_return(true)
      
      t.logged_in?
    end

    it 'returns true if session_id is not nil' do
      t = TestUser.new
      t.stub!(:session_id) { Object.new }
      
      t.logged_in?.should be_true
    end

    it 'returns false if session_id is nil' do
      t = TestUser.new
      t.stub!(:session_id) { nil }
      
      t.logged_in?.should be_false
    end
  end

  describe '#set_current_user' do
    before :each do
      @user = TestUser.new(12)
    end

    it 'takes a user as an argument and sets the session_id as their id' do
      session = Hash[]
      UserServices::Authentication.set_as_current_user(session, @user)
      session[:session_id].should == @user.id
    end
  end

  
end
