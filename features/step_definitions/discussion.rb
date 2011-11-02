Given /^A user exists$/ do
  Group.create(:name => 'sample',
               :password => 'password')
  User.create(:email => 'joe@email.com',
              :group_id => Group.first(:name => 'sample').id)
end

Given /^A discussion exists$/ do
  Discussion.create(:group_id => Group.first(:name => 'sample').id)
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

  discussion = Discussion.first(:group_id => Group.first(:name => 'sample').id)
  joe = User.first(:email => 'joe@email.com')

  Comment.create(:author => joe,
                 :discussion_id => discussion.id,
                 :body => 'OMG, I love it!')
  Comment.create(:author => joe,
                 :discussion_id => discussion.id,
                 :body => 'ZOMG, I double love it!')
end

When /^I look at the discussions$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I see the comments$/ do
  pending # express the regexp above with the code you wish you had
end
