Given /^I visit the groups tab$/ do
  pending # express the regexp above with the code you wish you had
end

Given /^I add a group$/ do
  pending # express the regexp above with the code you wish you had
end

When /^I visit the groups tab$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I see the group I just created$/ do
  pending # express the regexp above with the code you wish you had
end

Given /^I add a group with users$/ do
  pending # express the regexp above with the code you wish you had
end

When /^I visit a user in that group$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I see she is a member of that group$/ do
  pending # express the regexp above with the code you wish you had
end

Given /^There are existing groups$/ do
  pending # express the regexp above with the code you wish you had
end

Given /^I edit a group$/ do
  pending # express the regexp above with the code you wish you had
end

Given /^I add a new user$/ do
  pending # express the regexp above with the code you wish you had
end

When /^I visit that user page$/ do
  pending # express the regexp above with the code you wish you had
end

__END__
Given /^I visit the calculator page$/ do
  visit '/add'
end

Given /^I fill in '(.*)' for '(.*)'$/ do |value, field|
  fill_in(field, :with => value)
end

When /^I press '(.*)'$/ do |name|
  click_button(name)
end

Then /^I should see '(.*)'$/ do |text|
  response_body.should contain(/#{text}/m)
end
