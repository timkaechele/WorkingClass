require File.expand_path('../test_helper.rb', __FILE__)

class TaskTest < Minitest::Test

  include WorkingClass


  def test_initialize
    task = Task.new "Buy oranges"

    assert_instance_of(Task, task)
    assert_equal "Buy oranges", task.name
    assert !task.is_finished?
    assert_nil task.date
    assert_nil task.reminder
  end

  def test_initialize_with_options
    task = Task.new "Buy even more oranges", :is_finished => true, :reminder => DateTime.new, 
                                             :date => Date.new

    assert_equal "Buy even more oranges", task.name
    assert task.is_finished?
    assert_instance_of DateTime, task.reminder
    assert_instance_of Date, task.date
  end

  def test_is_upcoming_today
    task = Task.new "Futurama Marathon", :date => Date.today

    assert(task.is_upcoming)
  end

  def test_is_upcoming_tomorrow
    task = Task.new "Eat healthy", :date => Date.today + 1

    assert(task.is_upcoming)
  end

  def test_is_upcoming_yesterday
    task = Task.new "task lists are great", :date => Date.today - 1

    assert(!task.is_upcoming)
  end

  def test_is_upcoming_already_finished
    task = Task.new "Backup all the files", :is_finished => true, :date => Date.today

    assert(!task.is_upcoming)
  end

  def test_is_upcoming_already_finished_tomorrow
    task = Task.new "Eat chips", :is_finished => true, :date => Date.today + 1

    assert(!task.is_upcoming)
  end

  def test_is_upcoming_without_date
    task = Task.new "Backup all the files"

    assert(task.is_upcoming)
  end

  def test_is_tomorrow
    task = Task.new "Eat chips", :date => Date.today + 1

    assert(task.is_tomorrow)
  end

  def test_is_tomorrow_was_actually_yesterday
    task = Task.new "Eat chips", :date => Date.today - 1

    assert(!task.is_tomorrow)
  end

  def test_is_tomorrow_is_actually_next_week
    task = Task.new "Eat chips", :date => Date.today + 9

    assert(!task.is_tomorrow)
  end

  def test_is_tomorrow_without_a_date
    task = Task.new "Eat chips"

    assert(task.is_tomorrow)
  end

  def test_is_tomorrow_already_finished
    task = Task.new "Eat chips", :is_finished => true, :date => Date.today + 1

    assert(!task.is_tomorrow)
  end

  def test_alias_methods

    task = Task.new "my awesome task"

    assert_respond_to(task, :is_finished?)
    assert_respond_to(task, :finished?)

    assert_respond_to(task, :is_tomorrow?)
    assert_respond_to(task, :tomorrow?)

    assert_respond_to(task, :is_upcoming?)
    assert_respond_to(task, :upcoming?)
  end

end
