Factory.define :group, :class => MoxieApp::Group do |t|
  t.name 'Group'
  t.password 'password'
end

# http://www.snowblink.co.uk/archives/2009/04/24/factory-girl-and-has-many-through
Factory.define :user, :class => MoxieApp::User do |t|
  t.sequence(:email) { |n| "email#{n}@factory.com" }
  t.group_id { |a| a.association(:group).id }
end

Factory.define :lesson, :class => MoxieApp::Lesson do |t|
  t.title 'Title'
  t.sequence(:slug) { |n| "slug#{n}" }
  t.body 'This is just some text'
  t.video_title 'title'
  t.poster_name 'sample.jpg'
end
