require 'spec_helper'
require 'user_services'


class TestUser
  include UserServices::Authentication

  def initialize
  end

end

describe UserServices::Authentication do

  describe '#logged_in?' do
    it 'calls the current_account method' do
      t = TestUser.new
      t.should_receive(:current_account)#.with("password").and_return(true)
      
      t.logged_in?
    end

    it 'returns true if current_account is not nil' do
      t = TestUser.new
      t.stub!(:current_account) { Object.new }
      
      t.logged_in?.should be_true
    end

    it 'returns false if current_account is nil' do
      t = TestUser.new
      t.stub!(:current_account) { nil }
      
      t.logged_in?.should be_false
    end
  end
  
end
