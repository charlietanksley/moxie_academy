require 'spec_helper'

describe "My App" do
  def app
    @app ||= MoxieApp
  end

  it "should respond to /" do
    get '/'
    last_response.should be_ok
  end

end
