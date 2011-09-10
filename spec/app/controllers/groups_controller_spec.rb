require 'spec_helper'

describe "GroupsController" do
  before do
    get "/"
  end

  pending "returns hello world" do
    last_response.body.should == "Hello World"
  end
end
