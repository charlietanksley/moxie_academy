require 'spec_helper'

describe "Lesson Model" do
  let(:lesson) { Lesson.new }
  it 'can be created' do
    lesson.should_not be_nil
  end
end
