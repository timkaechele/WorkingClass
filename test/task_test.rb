require File.expand_path('../test_helper.rb', __FILE__)

class TaskTest < Minitest::Test

  include WorkingClass

  def test_initialize
    task = Task.new(true, "Hello World")

    assert(task.is_finished?)
    assert_equal("Hello World", task.name)
    assert(!task.has_reminder?)
    assert_nil(task.reminder)
  end

  def test_initialize_with_reminder
    task = Task.new(false, "Good Morning", Time.new(2016, 10, 5))

    assert(!task.is_finished)
    assert_equal("Good Morning", task.name)
    assert(task.has_reminder)
    assert_equal(Time.new(2016, 10, 5), task.reminder)
  end

end
