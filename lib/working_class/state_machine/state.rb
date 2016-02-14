module WorkingClass
  module StateMachine
    class State

      attr_reader :name, :is_start, :is_end

      def initialize(name, is_start, is_end)
        @name = name
        @is_start = is_start
        @is_end = is_end
      end

      alias :is_start? :is_start
      alias :is_end? :is_end

      def to_s
        self.name
      end
    end
  end
end