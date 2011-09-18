require 'spec_helper'

#describe 'Within the admin section,', :type => :request do
#  before(:all) do
#    TestHelper.create_test_group
#  end
#
#  before(:each) do
#    visit #admin_login_path
#    fill_in 'login[name]', :with => 'admin'
#    fill_in 'login[password]', :with => 'password'
#    click_button 'Sign In'
#  end
#
#  it 'you go to the main page when you first log in' do
#    current_path.should eq('/admin')
#  end
#
#  describe 'you can manipulate lessons:' do
#    before :each do
#      @title = 'From the Test'
#      @slug = 'test-lesson'
#      @video = 'test'
#      @poster = 'test.jpg'
#      @body = 'This is the content of the page.'
#    end
#
#    it 'view all lessons' do
#      visit #admin_lesson_path
#      page.has_xpath?('//table/tr')
#      page.has_content? 'Edit'
#      page.has_content? 'Delete'
#    end
#
#    it 'create new lesson' do
#      visit #new_lesson_path
#      fill_in 'lesson[title]', :with => @title
#      fill_in 'lesson[slug]', :with => @slug
#      fill_in 'lesson[video_title]', :with => @video
#      fill_in 'lesson[poster_name]', :with => @poster
#      fill_in 'lesson[body]', :with => @body
#
#      click_button 'Create'
#      current_path.should eq("/lessons/#{@slug}")
#      page.has_content? @title
#      page.has_content? @body
#    end
#
#    it 'edit a lesson' do
#      i = Lesson.create(:title => 'whatever', :slug => @slug, :video_title => 'sure')
#      visit "/admin/lessons/#{i.id}/edit"
#      fill_in 'lesson[title]', :with => 'This has changed'
#      click_button 'Update'
#      visit "/lessons/#{@slug}"
#
#      page.has_content? 'This has changed'
#    end
#
#    it 'destroy a lesson' do
#      visit '/admin/new-lesson'
#      fill_in 'lesson[title]', :with => 'T'
#      fill_in 'lesson[slug]', :with => 'destroyed'
#      fill_in 'lesson[video_title]', :with => @video
#      fill_in 'lesson[poster_name]', :with => @poster
#      fill_in 'lesson[body]', :with => @body
#      click_button 'Create'
#
#      lesson = Lesson.first(:slug => 'destroyed')
#      visit '/admin/lessons'
#      click_link "destroy-#{lesson.id}"
#
#      visit "/lessons/destroyed"
#      current_path.should eq('/')
#    end
#  end
#
#  describe 'you can manipulate users:' do
#    before :each do
#      Group.create(:name => 'First Group', :password => 'password')
#      @group = Group.first(:name => 'First Group')
#    end
#
#    it 'view all users' do
#      visit #admin_user_path
#      page.has_xpath?('//table/tr')
#      page.has_content? 'Edit'
#      page.has_content? 'Delete'
#    end
#
#    it 'add a user' do
#      visit #admin_user_path
#      fill_in 'user[email]', :with => 'c@e.com'
#      check "#{@group.id}"
#      click_button 'Create'
#
#      page.has_content? 'c@e.com'
#    end
#  end
#
#
#  
#end
