Factory.define :group, :class => Group do |t|
  t.name 'Group'
  t.password 'password'
end

# http://www.snowblink.co.uk/archives/2009/04/24/factory-girl-and-has-many-through
Factory.define :user, :class => User do |t|
  t.sequence(:email) { |n| "email#{n}@factory.com" }
  t.group_id { |a| a.association(:group).id }
end

Factory.define :lesson, :class => Lesson do |t|
  t.sequence(:title) { |n| "Title #{n}" }
  t.sequence(:slug) { |n| "slug#{n}" }
  t.body 'This is just some text'
  t.video_title 'title'
  t.poster_name 'sample.jpg'
end

Factory.define :discussion, :class => Discussion do |t|
  t.group_id { |a| a.association(:group).id }
end

Factory.define :comment, :class => Comment do |t|
  t.user_id { |a| a.association(:user).id }
  t.discussion_id { |a| a.association(:group).id }
  t.sequence(:body) { |n| "some comment! #{n}" }
end
