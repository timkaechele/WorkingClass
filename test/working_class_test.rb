require File.expand_path('../test_helper.rb', __FILE__)

class WorkingClassTest < Minitest::Test

  def test_load_file
    path = File.expand_path('../examples/example_1.txt', __FILE__)
    tasklist = WorkingClass.load_file(path)

    assert_instance_of(WorkingClass::Tasklist, tasklist)
    assert_equal(1, tasklist.tasks.length)
    assert_equal("A cool todolist", tasklist.name)
  end

  def test_load
    path = File.expand_path('../examples/example_1.txt', __FILE__)
    string = File.open(path, 'r').read()
    tasklist = WorkingClass.load(string)

    assert_instance_of(WorkingClass::Tasklist, tasklist)
    assert_equal(1, tasklist.tasks.length)
    assert_equal("A cool todolist", tasklist.name)
  end

end