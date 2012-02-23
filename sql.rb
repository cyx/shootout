require "sequel"

DB = Sequel.connect(ENV["DATABASE_URL"] || "sqlite://todos.sqlite3")

class User < Sequel::Model
  def todos
    Todo.filter(user_id: id)
  end
end

class Todo < Sequel::Model
end

module Startup
  def self.now!
    DB[:users].truncate
    DB[:todos].truncate

    user = DB[:users].insert(id: 1)
  
    descs = [
      "We need to measure, measure, measure!",
      "Learn how to evolve",
      "Complete the training program",
      "Buy some milk & cereals",
      "Make coffee",
      "Eat Korean barbeque"
    ]

    descs.each_with_index { |desc, idx| 
      DB[:todos].insert(id: idx + 1, description: desc, user_id: 1)
    }
  end
end
