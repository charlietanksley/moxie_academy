require 'spec_helper'

describe "SessionsController" do

  it 'shows the login screen at the /login url' do
    get '/login'

    last_response.body.should include('Login')
  end


end
