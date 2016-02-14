module WorkingClass
  module Serializer
    class TasklistSerializer
      def initialize(task_serializer)
        @task_serializer = task_serializer
      end

      def serialize(tasklist)
        output = "#{tasklist.name}\n---\n"
        tasklist.tasks.each { |t| output += @task_serializer.serialize(t) }
        output
      end
    end
  end
end