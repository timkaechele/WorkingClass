module WorkingClass
  module Serializer

    class StateMachineTransitionSerializer
      def serialize(transition)
        "\"#{transition.from.to_s}\" -> \"#{transition.to.to_s}\"" +
          " [ label = \"#{transition.regex.to_s}\" ];\n"
      end
    end


    class StateMachineSerializer
      def initialize(state_machine_transition_serializer)
        @transition_serializer = state_machine_transition_serializer
      end

      def serialize(state_machine)
        end_states = state_machine.end_states.map do |s|
          s.to_s
        end.join(" ")

        transitions = state_machine.transitions.map do |t|
          @transition_serializer.serialize(t)
        end.join(" ")

        output = """digraph finite_state_machine {
                 rankdir=LR;
                 size=\"8,5\";
                 node[shape = doublecircle]; #{end_states};
                 node[shape = circle];
                 #{transitions}}"""
      end
    end

  end
end