require "cuba"
require "../#{ENV["STORE"] || "sql"}"

Startup.now!

Cuba.define do
  on "" do
    res.write render("views/home.erb")
  end

  on "user/:id/todos" do |id|
    @todos = User[id].todos

    res.write render("views/todos.erb")
  end
end

run Cuba
