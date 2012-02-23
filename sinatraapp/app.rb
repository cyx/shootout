require "sinatra/base"

require "../models"

Startup.now!

class App < Sinatra::Base
  disable :protection, :logging, :sessions, :show_exceptions

  get "/" do
    erb :home
  end

  get "/user/:id/todos" do |id|
    @user = User[id]
    @todos = Todo.find(user_id: @user.id)

    erb :todos
  end
end

App.run!
