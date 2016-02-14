module WorkingClass
  module StateMachine
    class StateGenerator
      def initialize
        @current_index = 0
      end

      def generate_state(is_start, is_end)
        @current_index += 1
        State.new(@current_index, is_start, is_end)
      end
    end
  end
end