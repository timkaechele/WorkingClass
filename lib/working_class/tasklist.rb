module WorkingClass

  # A represantation of a Tasklist
  #
  # @attr_reader name [String] the name of the Tasklist
  # @attr_reader tasks [Array<WorkingClass::Task>] the tasks of the Tasklist
  class Tasklist

    attr_reader :name

    attr_reader :tasks

    # Initializes a new Tasklist with a name and optional Tasks
    #
    # @param name [String] the tasklist name
    # @param tasks [Array<WorkingClass::Task>] an array with Tasks
    # @return [WorkingClass::Tasklist] the actual Tasklist object
    #
    def initialize(name, tasks = [])
      @name = name
      @tasks = tasks
    end

    # Returns all the upcoming tasks
    #
    # @return [Array<WorkingClass::Task>] an Array with the upcoming tasks
    #
    def upcoming_tasks
      @tasks.select { |task| task.is_upcoming }
    end

    # Returns all the tasks that are due tomorrow
    #
    # @return [Array<WorkingClass::Task>] an Array with the tasks due tomorrow
    #
    def tasks_due_tomorrow
      @tasks.select { |task| task.is_tomorrow }
    end

    # Returns all the finished tasks
    #
    # @return [Array<WorkingClass::Task>] an Array the finished tasks
    #
    def finished_tasks
      @tasks.select { |task| task.is_finished }
    end

    # Returns all the unfinished tasks
    #
    # @return [Array<WorkingClass::Task>] an Array with the unfinished tasks
    #
    def unfinished_tasks
      @tasks.select { |task| !task.is_finished }
    end

  end
end
