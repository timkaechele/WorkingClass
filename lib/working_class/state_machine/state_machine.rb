module WorkingClass
  module StateMachine
    class StateMachine

      attr_reader :states, :transitions

      def initialize(states, transitions)
        @states = states
        @transitions = transitions
        @processors = Hash.new
      end

      def register_handler(transition, handler)
        if(@processors[transition] == nil)
          @processors[transition] = Array.new
        else
          @processors[transition] << handler
        end
      end

      def start_state
        @states.select { |s| s.is_start? }.take(1).first
      end

      def end_states
        @states.select { |s| s.is_end? }
      end

    end
  end
end