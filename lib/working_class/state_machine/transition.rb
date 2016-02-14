module WorkingClass
  module StateMachine
    class Transition

      attr_reader :from, :to, :regex

      def initialize(from, to, regex)
        @from = from
        @to = to
        @regex = regex
      end

      def to_s
        "#{from.to_s} -[#{regex.to_s}]-> #{to.to_s}"
      end
    end
  end
end