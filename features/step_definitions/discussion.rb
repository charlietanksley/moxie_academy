Given /^A user exists$/ do
  @group = Group.first_or_create(:name => 'sample',
                        :password => 'password')
  @user = User.first_or_create(:email => 'joe@email.com',
                      :group_id => Group.first(:name => 'sample').id)
end

Given /^A discussion exists$/ do
  @discussion = Discussion.first_or_create(:group_id => @group.id)#Group.first(:name => 'sample').id)
end
  
Given /^I am logged in as a user$/ do
  Given "A user exists"

  visit MoxieAcademy.url(:sessions, :new)
  fill_in 'login[email]', :with => 'joe@email.com'
  fill_in 'login[password]', :with => 'password'
  click_on 'Sign In'
end

Given /^There are some comments$/ do
  Given 'A discussion exists'

  @comment1 = Comment.create(:user_id => @user.id,
                             :discussion_id => @discussion.id,
                             :body => 'OMG, I love it!')
  @comment2 = Comment.create(:user_id => @user.id,
                             :discussion_id => @discussion.id,
                             :body => 'ZOMG, I double love it!')
end

When /^I look at the discussions$/ do
  visit MoxieAcademy.url(:discussions, :index)
end

Then /^I see the comments$/ do
  page.should have_content @comment1.body
  page.should have_content @comment2.body
end
