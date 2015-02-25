module WorkingClass

  # A basic represantation of a Task
  #
  # @attr_reader name [String] the task name
  # @attr_reader is_finished [Boolean] true if the task is finished
  # @attr_reader date [Date] the day the task is due
  # @attr_reader reminder [DateTime] a DateTime with a reminder
  class Task

    attr_reader :name
    attr_reader :date
    attr_reader :reminder
    attr_reader :is_finished

    alias :is_finished? :is_finished
    alias :finished? :is_finished

    # Initializes a new task object with a name, and options
    #
    # @param name [String] the task name
    # @param options [Hash] an options hash
    #
    # @option options [Boolean] :is_finished (false) true if the task is finished
    # @option options [Date] :date (nil) the date when the task is due
    # @option options [DateTime] :reminder (nil )a DateTime with a reminder
    #
    def initialize name, options = {}
      options = {is_finished: false, date: nil, reminder: nil}.merge(options)
      @name = name
      @is_finished = options[:is_finished]
      @date = options[:date]
      @reminder = options[:reminder]
    end

    # Returns true if the task is upcoming
    #
    # A Task without a date is always upcoming.
    # @todo add example
    #
    # A finished task is never upcoming.
    # @todo add example
    #
    # @return [Boolean] true if the task is upcoming
    def is_upcoming
      if @is_finished
        false
      elsif !@date.nil?
        Date.today <= @date
      else
        true
      end
    end

    alias :is_upcoming? :is_upcoming
    alias :upcoming? :is_upcoming

    # Returns true if the task is due tomorrow
    #
    # A Task without a date is always due tomorrow.
    # @todo add example
    #
    # A finished task is never due tomorrow.
    # @todo add example
    #
    # @return [Boolean] true if the task is due tomorrow
    def is_tomorrow
      if @is_finished
        false
      elsif date.nil?
        true
      else
        Date.today + 1 == @date
      end
    end

    alias :is_tomorrow? :is_tomorrow
    alias :tomorrow? :is_tomorrow


  end
end
