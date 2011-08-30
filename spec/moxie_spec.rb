require 'spec_helper'

describe "My App" do
  def app
    @app ||= MoxieApp
  end

  it "should respond to /" do
    get '/'
    last_response.should be_ok
  end

end

describe 'If you are not logged in, the app is basically worthless', :type => :request do

  it "should require login to access lessons" do
    visit ('/lessons')
    current_path.should eq('/login')
  end

  it "should require login to access a given lesson" do
    visit '/lessons/first'
    current_path.should eq('/login')
  end

end

describe 'If you are logged in, we get content', :type => :request do

  before :each do
    #User.create(:email => 'test@email.com',
    #            :password => 'soinsecure',
    #            :first_name => 'C',
    #            :last_name => 'T',
    #            :paid => true)
    #visit '/login'
    #fill_in 'Email', :with => 'user@example.com'
    #fill_in 'Password', :with => 'password'
    driver.set_cookie "#{logged_in}=true"
  end


  it 'should let you see all lessons if you are logged in' do
    session[:logged_in] = true
    visit '/lessons'
    current_path.should eq('/lessons')
  end
end
