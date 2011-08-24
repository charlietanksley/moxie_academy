require 'sinatra/base'

class MoxieApp < Sinatra::Base

  set :public, File.dirname(__FILE__) + '/public'

  get '/' do
    send_file File.join(settings.public, 'pages', 'index.html')
  end

  get '/:page' do
    send_file File.join(settings.public, 'pages', "#{params[:page]}.html")
  end

end
