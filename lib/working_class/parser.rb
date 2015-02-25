require 'date'

module WorkingClass
  # The actual syntax parser
  #
  class Parser

    # Initializes a new Parser object with a given WorkingClass syntax string
    #
    # @param string [String] the raw string with the WorkingClass syntax
    # @return [WorkingClass::Parser] a parser instance
    #
    def initialize(string)
      @raw_string = string
      @date_regex = /(?:\d{1,2}\.){2}\d{2,4}/
      @time_regex = /\d{1,2}:\d{1,2}/
    end

    # Parses the syntax and returns an Hash with the result
    #
    # @return [Hash] a Hash representation of the parsed tasklist
    #
    def to_h
      {
        name: tasklist_name,
        tasks_count: tasks.length,
        tasks: tasks
      }
    end

    # Parses the syntax and returns a WorkingClass::Tasklist instance
    #
    # @return [WorkingClass::Tasklist] a Tasklist instance of the parsed tasklist
    #
    def to_tasklist
      tasks = Array.new
      raw = self.to_h
      raw[:tasks].each do |t|
        task = Task.new(t[:name], t)
        tasks << task
      end
      Tasklist.new raw[:name], tasks
    end

    private
      def tasklist_name_regex
        /(.*)\n---/
      end

      def task_regex
        /\[(.*)\] *(?:\{(.*)\})? *(?:\((.*)\)){0,1} *(.*)/
      end

      def tasklist_name
        @raw_string.match(tasklist_name_regex).captures.first
      end

      def tasks
        tasks = []
        @raw_string.scan(task_regex).each do |match|
          task = Hash.new
          task[:is_finished] = extract_is_finished(match[0])
          task[:date] = extract_date(match[1])
          task[:reminder] = extract_reminder(task[:date], match[2])
          task[:name] = extract_name(match[3])
          tasks << task
        end
        tasks
      end

      def extract_is_finished(match)
        match = match.strip
        if match == "x" or match == "X"
          true
        else
          false
        end
      end

      def extract_date(match)
        if match.nil?
          return nil
        end

        if match.scan(@date_regex)
          # @todo rescue the right exception
          begin
            normalize_date(match)
          rescue
            nil
          end
        else
          nil
        end
      end


      def extract_name(match)
        if !match.nil?
          match.strip
        else
          ""
        end
      end

      def normalize_date(date_string)
        parts = date_string.split(".")
        if parts[2].length == 2
          parts[2] = "20" + parts[2]
        end
        parts = parts.map { |p| p.to_i }
        Date.new(parts[2], parts[1], parts[0])
      end

      # Shame Shame
      # @todo REFACTOR!!!!!1eleven!1
      def extract_reminder(task_date, match)
        if match.nil?
          return nil
        end

        if match.empty? and !task_date.nil?
          return DateTime.parse(task_date.to_s + " 9:00")
        elsif match.empty? and task_date.nil?
          return nil
        end

        date = nil
        time = nil

        absolute_date = match.scan(/(#{@date_regex})/)
        relative_date = match.scan(/(-\d{1,2})/)
        match_time    = match.scan(/(#{@time_regex})/)

        if absolute_date.empty? and (!relative_date.empty? and !task_date.nil?)
          date = task_date + relative_date.flatten.first.to_i
        elsif !absolute_date.empty?
          # @todo rescue the right exception
          begin
            date = normalize_date(absolute_date.flatten.first)
          rescue
            date = nil
          end
        end

        if !match_time.empty?
          time = match_time
        end

        if !date.nil? and !time.nil?
          DateTime.parse(date.to_s + " #{time}")
        elsif (date.nil? and !task_date.nil?) and !time.nil?
          DateTime.parse(task_date.to_s + " #{time}")
        elsif !date.nil? and time.nil?
          DateTime.parse(date.to_s + " 9:00")
        else
          return nil
        end

      end


  end
end

