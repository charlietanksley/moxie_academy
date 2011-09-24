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

  # Note that the verify_logged_in, session_id and
  # verify_visible_to_user methods cannot be tested here because they
  # rely on some Padrino stuff.

  describe '#logged_in?' do
    it 'calls the session_id method' do
      t = TestUser.new
      t.should_receive(:session_id)
      
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

  describe '#visible_to_user?' do
    let(:user) { double("user") }
    let(:resource) { double("resource") }

    before :each do
      @t = TestUser.new
    end

    it 'returns true if the user is permitted to see the resource' do
      user.stub(:group) { 1 }
      resource.stub(:groups) { [1] }

      @t.visible_to_user?(user, resource).should be_true
    end

    it 'returns false if the user is not permitted to see the resource' do
      user.stub(:group) { 1 }
      resource.stub(:groups) { [2] }

      @t.visible_to_user?(user, resource).should be_false
    end
  end

end
