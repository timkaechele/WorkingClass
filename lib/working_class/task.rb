module WorkingClass
  class Task
    attr_accessor :is_finished, :name, :reminder

    def initialize(is_finished, name, reminder = nil)
      @is_finished = is_finished
      @name = name
      @reminder = reminder
    end

    def has_reminder
      reminder != nil
    end

    alias :has_reminder? :has_reminder
    alias :is_finished? :is_finished
  end
end