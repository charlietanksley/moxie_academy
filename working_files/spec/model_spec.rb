require 'spec_helper'

# USER {{{

describe MoxieApp::User, 'A new user' do

  it 'succeeds if all the parts are in place' do
    user = build :user
    user.should be_valid
  end

  it 'creation fails without email' do
    user = build(:user, :email => '')
    user.should_not be_valid
  end

  it 'creation fails without group_id' do
    user = build(:user, :group_id => '')
    user.should_not be_valid
  end

  pending 'belongs to a group'

end

# END USER }}}
# GROUP {{{

describe MoxieApp::Group, 'A new group' do

  it 'succeeds if all the parts are in place' do
    group = build :group
    group.should be_valid
  end

  it 'creation fails without a password' do
    group = build :group, :password => ''
    group.should_not be_valid
  end

  it 'creation fails if the password is not unique' do
    g1 = create :group
    group = build :group, :password => g1.password
    group.should_not be_valid
  end

  pending 'has many users' 

end

# END GROUP }}}
# LESSON {{{

describe MoxieApp::Lesson, 'A new lesson' do

  it 'succeeds if all the parts are in place' do
    lesson = build :lesson
    lesson.should be_valid
  end

  it 'creation fails without a video title' do
    lesson = build :lesson, :video_title => ''
    lesson.should_not be_valid
  end

  it 'creation fails without a slug' do
    lesson = build :lesson, :slug => ''
    lesson.should_not be_valid
  end

  it 'creation fails if the slug has spaces or non-safe characters' do
    lesson = build :lesson, :slug => 'this slug'
    lesson.should_not be_valid

    lesson = build :lesson, :slug => 'this!slug'
    lesson.should_not be_valid
  end

  it 'creation fails if the slug is not unique' do
    l1 = create :lesson
    lesson = build :lesson, :slug => l1.slug 
    lesson.should_not be_valid
  end

end

# END LESSON }}}
