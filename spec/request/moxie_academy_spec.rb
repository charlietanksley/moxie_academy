require 'spec_helper'

describe 'If you are not logged in, you', :type => :request do

  it "get redirected when you try to view the lessons overview" do
    visit MoxieAcademy.url(:lessons, :index)
    current_path.should eq(MoxieAcademy.url(:sessions, :new))
  end

  it "get redirected when you try to view a specific lesson" do
    l = TestHelper.create_test_lesson
    visit MoxieAcademy.url(:lessons, :show, :slug => l.slug)
    current_path.should eq MoxieAcademy.url(:sessions, :new)
  end

end

describe 'Failed attempts to log in:', :type => :request do
  before :each do
    @g = TestHelper.create_test_group
    @u = TestHelper.create_test_user_with_password @g.id
    @l = TestHelper.create_test_lesson
  end

  it 'redirects you to the login page if you enter the password incorrectly' do
    visit MoxieAcademy.url(:sessions, :new)
    fill_in 'login[email]', :with => @u.email
    fill_in 'login[password]', :with => 'bad_password'
    click_button 'Sign In'
    current_path.should eq MoxieAcademy.url(:sessions, :new)
  end

  it 'redirects you to the login page if you enter your email incorrectly' do
    visit MoxieAcademy.url(:sessions, :new)
    visit '/login'
    fill_in 'login[email]', :with => 'something@random.com'
    fill_in 'login[password]', :with => @u.group.password
    click_button 'Sign In'
    current_path.should eq MoxieAcademy.url(:sessions, :new)
  end

end

describe 'If you are logged in,', :type => :request do
  before(:each) do
    @g = TestHelper.create_test_group
    @u = TestHelper.create_test_user_with_password(@g.id)
    @l = TestHelper.create_test_lesson_with_group(@u)
    visit MoxieAcademy.url(:sessions, :new)
    fill_in 'login[email]', :with => @u.email
    fill_in 'login[password]', :with => @u.group.password
    click_on 'Sign In'
  end

  it 'you can view the lessons overview page' do
    visit MoxieAcademy.url(:lessons, :index)
    current_path.should eq MoxieAcademy.url(:lessons, :index)
  end

  it 'you can view a specific lesson if it is visible to you' do
    path = MoxieAcademy.url(:lessons, :show, :slug => @l.slug)
    visit path
    current_path.should eq path
  end

  it 'you cannot view a specific lesson if it is not visible to you' do
    l = create(:lesson)
    
    visit MoxieAcademy.url(:lessons, :show, :slug => l.slug)
    current_path.should eq MoxieAcademy.url(:lessons, :index)
  end


  it 'you get redirected if the page does not exist' do
    visit MoxieAcademy.url(:lessons, :show, :slug => 'this-does-not-exist')
    current_path.should eq MoxieAcademy.url(:lessons, :index)
  end

  it 'you can log out' do
    visit '/sessions/logout'
    current_path.should eq MoxieAcademy.url(:sessions, :new)
  end
end
