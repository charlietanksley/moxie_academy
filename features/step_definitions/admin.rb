# GIVEN {{{

Given /^I am logged in as an admin$/ do
  Account.create(:email => 'admin@gmail.com', :password => 'sample', :password_confirmation => 'sample', :role => 'admin')
  visit Admin.url(:sessions, :new)
  fill_in 'email', :with => 'admin@gmail.com'
  fill_in 'password', :with => 'sample'

  click_on 'Sign In'
end


When /^A lesson exists$/i do
  Lesson.create(:title => 'A Cucumber Lesson', :slug => 'cuke', :video_title => 'sample')
end

When /^I click on new$/ do
  click_link 'New'
end

When /^I add a group$/ do
  fill_in :name, :with => 'Created in Cucumber'
  fill_in :password, :with => 'cukes_are_not_so_bad'
  click_on 'Save'
end

# Changed from Given
When /^I add a group from the group tab$/ do
  When "I click on new"
  When 'I add a group'
end

# Changed from Given
When /^I add a group with users$/ do
  pending # express the regexp above with the code you wish you had
end

# Changed from Given
When /^There are existing groups$/ do
  pending # express the regexp above with the code you wish you had
end

# Changed from Given
When /^I edit a group$/ do
  pending # express the regexp above with the code you wish you had
end

# Changed from Given
When /^I add a new user$/ do
  pending # express the regexp above with the code you wish you had
end


# END GIVEN }}}
# WHEN {{{

When /^I visit the dashboard$/ do
  visit Admin.url(:base, :index)
end

When /^I visit the groups tab$/ do
  visit Admin.url(:groups, :new)
end

When /^I visit a user in that group$/ do
  pending # express the regexp above with the code you wish you had
end

When /^I visit that user page$/ do
  pending # express the regexp above with the code you wish you had
end

# END WHEN }}}
# THEN {{{

Then /^I see the lesson$/ do
  page.should have_content 'A Cucumber Lesson'
end

Then /^I see the group I just created$/ do
  page.should have_content 'cukes_are_not_so_bad'

end

Then /^I see she is a member of that group$/ do
  pending # express the regexp above with the code you wish you had
end

# END THEN }}}
#
# TESTING

Then /^I should see whatever the hell I want$/ do
  #page.should have_content 'aSecurePasswordPlease'
  current_path.should == '/admin/groups/new'
end
