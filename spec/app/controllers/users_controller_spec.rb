require 'spec_helper'

describe "UsersController" do
  before do
    get "/"
  end

  pending "returns hello world" do
    last_response.body.should == "Hello World"
  end
end
