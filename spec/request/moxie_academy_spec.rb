require 'spec_helper'

describe 'If you are not logged in, you', :type => :request do

  pending "get redirected when you try to view the lessons overview" do
    visit ('/lessons')
    current_path.should eq('/login')
  end

  pending "get redirected when you try to view a specific lesson" do
    visit '/lessons/first'
    current_path.should eq('/login')
  end

end

describe 'Failed attempts to log in:', :type => :request do
  before :each do
    @g = TestHelper.create_test_group
    @u = TestHelper.create_test_user_with_password @g.id
    @l = TestHelper.create_test_lesson
  end

  pending 'redirects you to the login page if you enter the password incorrectly' do
    visit '/login'
    fill_in 'login[email]', :with => @u.email
    fill_in 'login[password]', :with => 'bad_password'
    click_button 'Sign In'
    current_path.should eq('/login')
  end

  pending 'redirects you to the login page if you enter your email incorrectly' do
    visit '/login'
    fill_in 'login[email]', :with => 'something@random.com'
    fill_in 'login[password]', :with => @u.group.password
    click_button 'Sign In'
    current_path.should eq('/login')
  end

end

describe 'If you are logged in,', :type => :request do

  before(:each) do
    @g = TestHelper.create_test_group
    @u = TestHelper.create_test_user_with_password(@g.id)
    @l = TestHelper.create_test_lesson
    visit '/login'
    fill_in 'login[email]', :with => @u.email
    fill_in 'login[password]', :with => @u.group.password
    click_button 'Sign In'
  end

  pending 'you can view the lessons overview page' do
    visit '/lessons'
    current_path.should eq('/lessons')
  end

  pending 'you can view a specific lesson' do
    visit '/lessons/test'
    current_path.should eq('/lessons/test')
  end

  pending 'you get redirected if the page does not exist' do
    visit '/lessons/does-not-exist'
    current_path.should eq('/')
  end

  pending 'you can log out' do
    visit '/logout'
    current_path.should eq('/login')
  end
end
