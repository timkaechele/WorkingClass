module WorkingClass
  module Serializer

    class TaskSerializer
      def serialize(t)
        is_finished = t.is_finished ? "X" : " "
        name = t.name
        reminder = t.reminder.nil? ? "" : t.reminder.strftime("%m.%d.%Y %I:%M%P")
        "[#{is_finished}]{#{reminder}} #{name}\n"
      end
    end

  end
end