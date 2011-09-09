require 'spec_helper'

describe "Lesson Model" do
  it 'can be created' do
    lesson = Lesson.new
    lesson.should_not be_nil
  end

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
