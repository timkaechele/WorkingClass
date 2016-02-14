module WorkingClass
  class Tasklist
    attr_accessor :name, :tasks

    def initialize(name, tasks = [])
      @name = name
      @tasks = tass
    end

    def unfinished_tasks
      tasks.select { |t| !t.is_finished }
    end

    def finished_tasks
      tasks.select { |t| t.is_finished }
    end
  end
end
