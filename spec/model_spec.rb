require 'spec_helper'

# USER {{{

describe MoxieApp::User, 'A new user' do

  it 'creation fails without email' do
    user = build(:user)
    user.email.should == 'c'
  end

  pending 'creation fails without group_id'

  pending 'belongs to a group'

end

# END USER }}}
# GROUP {{{

describe MoxieApp::Group, 'A new group' do

  pending 'creation fails without a password'

  pending 'creation fails if the password is not unique'

  pending 'has many users' 

end

# END GROUP }}}
# LESSON {{{

describe MoxieApp::Lesson, 'A new lesson' do

  pending 'creation fails without a video title'

  pending 'creation fails without a slug'

  pending 'creation fails if the slug has spaces or non-safe characters'

  pending 'creation fails if the slug is not unique'

end

# END LESSON }}}
