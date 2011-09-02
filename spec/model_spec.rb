require 'spec_helper'

describe MoxieApp::User, 'A new user' do

  pending 'creation fails without email'

  pending 'creation fails without group_id'

  pending 'belongs to a group'

end

describe MoxieApp::Group, 'A new group' do

  pending 'creation fails without a password'

  pending 'creation fails if the password is not unique'

  pending 'has many users' 

end

describe MoxieApp::Lesson, 'A new lesson' do

  pending 'creation fails without a video title'

  pending 'creation fails without a slug'

  pending 'creation fails if the slug has spaces or non-safe characters'

  pending 'creation fails if the slug is not unique'

end
