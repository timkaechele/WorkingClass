require File.expand_path('../test_helper.rb', __FILE__)

class TasklistTest < Minitest::Test

  include WorkingClass

  def test_initialize
    tasklist = Tasklist.new('my list')

    assert_instance_of(Array, tasklist.tasks)
    assert_equal('my list', tasklist.name)
    assert_equal(0, tasklist.tasks.length)
  end

  def test_upcoming_tasks
    task_1 = Task.new("Task 1", :is_finished => true, :date => Date.today + 2)
    task_2 = Task.new("Task 2", :date => Date.today)
    task_3 = Task.new("Task 3", :is_finished => true, :date => Date.today - 1)
    tasks = [task_1, task_2, task_3]

    tasklist = Tasklist.new("example_task_list", tasks)
    expected = [task_2]

    assert_equal(expected, tasklist.upcoming_tasks)

  end

  def test_finished_tasks
    task_1 = Task.new("Task 1", :is_finished => true)
    task_2 = Task.new("Task 2")
    task_3 = Task.new("Task 3", :is_finished => true)
    tasks = [task_1, task_2, task_3]

    tasklist = Tasklist.new("example_task_list", tasks)
    expected = [task_1, task_3]

    assert_equal(expected, tasklist.finished_tasks)
  end

  def test_tasks_due_tomorrow
    task_1 = Task.new("Task 1", :is_finished => true, :date => Date.today + 1)
    task_2 = Task.new("Task 2")
    task_3 = Task.new("Task 3", :date => Date.today + 2)
    task_4 = Task.new("Task 4", :date => Date.today + 1 )

    tasks = [task_1, task_2, task_3, task_4]

    tasklist = Tasklist.new("example_task_list", tasks)
    expected = [task_2, task_4]

    assert_equal(expected, tasklist.tasks_due_tomorrow)
  end

  def test_unfinished_tasks
    task_1 = Task.new("Task 1", :is_finished => true)
    task_2 = Task.new("Task 2")
    task_3 = Task.new("Task 3")
    task_4 = Task.new("Task 4", :is_finished => true)

    tasks = [task_1, task_2, task_3, task_4]

    tasklist = Tasklist.new("example_task_list", tasks)
    expected = [task_2, task_3]

    assert_equal(expected, tasklist.unfinished_tasks)
  end


end
