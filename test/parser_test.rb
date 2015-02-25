require File.expand_path('../test_helper.rb', __FILE__)

class ParserTest < Minitest::Test

  include WorkingClass

  def load_example(example_name)
    path = File.expand_path("../examples/#{example_name}.txt", __FILE__)
    File.open(path, 'r').read()
  end

  def test_initialize
    text = load_example('example_1')
    parser = Parser.new(text)
    assert_instance_of(Parser, parser)
  end

  def test_to_a_simple_task
    text = load_example('example_1')
    parser = Parser.new(text)
    output = parser.to_h

    assert_instance_of(Hash, output)
    assert_instance_of(Array, output[:tasks])
    assert_instance_of(Hash, output[:tasks].first)

    assert_equal('A cool todolist', output[:name])
    assert_equal(1, output[:tasks_count])
    assert_equal('My Task Number 1', output[:tasks].first[:name])

    assert(!output[:tasks].first[:is_finished])
    assert_nil(output[:tasks].first[:date])
    assert_nil(output[:tasks].first[:reminder])
  end

  def test_to_a_simple_finished_task
    text = load_example('example_2')
    parser = Parser.new(text)
    output = parser.to_h

    assert_instance_of(Hash, output)
    assert_instance_of(Array, output[:tasks])
    assert_instance_of(Hash, output[:tasks].first)

    assert_equal('Groceries List', output[:name])
    assert_equal(1, output[:tasks_count])

    assert_equal('My finished Task', output[:tasks].first[:name])
    assert(output[:tasks].first[:is_finished])
    assert_nil(output[:tasks].first[:date])
    assert_nil(output[:tasks].first[:reminder])
  end

  def test_to_a_task_with_date
    text = load_example('example_3')
    parser = Parser.new(text)
    output = parser.to_h
    task_1 = output[:tasks].first
    task_2 = output[:tasks].last

    assert_instance_of(Hash, output)
    assert_instance_of(Array, output[:tasks])
    assert_instance_of(Hash, task_1)
    assert_instance_of(Hash, task_2)

    assert_equal('Development Todolist', output[:name])
    assert_equal(2, output[:tasks_count])

    assert_equal('Release WorkingClass', task_1[:name])
    assert(!task_1[:is_finished])
    assert_equal(Date.new(2015, 12, 12), task_1[:date])
    assert_nil(task_1[:reminder])

    assert_equal('Yolo', task_2[:name])
    assert(task_2[:is_finished])
    assert_equal(Date.new(2015, 2, 12), task_2[:date])
    assert_nil(task_2[:reminder])
  end

  def test_to_a_task_with_full_date
    text = load_example('example_4')
    parser = Parser.new(text)
    output = parser.to_h
    task_1 = output[:tasks].first
    task_2 = output[:tasks].last

    assert_instance_of(Hash, output)
    assert_instance_of(Array, output[:tasks])
    assert_instance_of(Hash, task_1)
    assert_instance_of(Hash, task_2)

    assert_equal('Shopping List', output[:name])
    assert_equal(2, output[:tasks_count])

    assert_equal('Buy some Jeans', task_1[:name])
    assert(!task_1[:is_finished])
    assert_equal(Date.new(2015, 1, 12), task_1[:date])
    assert_nil(task_1[:reminder])

    assert_equal('Buy more Jeans', task_2[:name])
    assert(!task_2[:is_finished])
    assert_equal(Date.new(2016, 7 ,5), task_2[:date])
    assert_equal(DateTime.new(2016, 7, 5, 9, 0), task_2[:reminder])
  end

  def test_to_a_task_with_absolute_reminder
    text = load_example('example_5')
    parser = Parser.new(text)
    output = parser.to_h
    task_1 = output[:tasks].first
    task_2 = output[:tasks].last

    assert_instance_of(Hash, output)
    assert_instance_of(Array, output[:tasks])
    assert_instance_of(Hash, task_1)
    assert_instance_of(Hash, task_2)

    assert_equal('Another List Another Day', output[:name])
    assert_equal(2, output[:tasks_count])

    assert_equal('Yolo', task_1[:name])
    assert(task_1[:is_finished])
    assert_nil(task_1[:date])
    assert_equal(DateTime.new(2015, 2, 15, 9, 0) ,task_1[:reminder])

    assert_equal('Yolo in the house', task_2[:name])
    assert(task_2[:is_finished])
    assert_equal(Date.new(2015, 2, 16), task_2[:date])

    assert_equal(DateTime.new(2015, 2, 15, 13, 0), task_2[:reminder])
  end

  def test_to_a_task_with_relative_reminder
    text = load_example('example_6')
    parser = Parser.new(text)
    output = parser.to_h
    task_1 = output[:tasks][0]
    task_2 = output[:tasks][1]
    task_3 = output[:tasks][2]

    assert_instance_of(Hash, output)
    assert_instance_of(Array, output[:tasks])
    assert_instance_of(Hash, task_1)
    assert_instance_of(Hash, task_2)

    assert_equal('Yeah more examples', output[:name])
    assert_equal(3, output[:tasks_count])

    assert_equal('Twitter Downtime', task_1[:name])
    assert(!task_1[:is_finished])
    assert_equal(Date.new(2012, 3, 17), task_1[:date])
    assert_equal(DateTime.new(2012, 3, 16, 9, 0) ,task_1[:reminder])

    assert_equal('Another Task', task_2[:name])
    assert(!task_2[:is_finished])
    assert_equal(Date.new(2015, 5, 12), task_2[:date])
    assert_equal(DateTime.new(2015, 5, 10, 5, 0) ,task_2[:reminder])

    assert_equal('Remind me!!', task_3[:name])
    assert(task_3[:is_finished])
    assert_equal(Date.new(2015, 3, 12), task_3[:date])
    assert_equal(DateTime.new(2015, 3, 12, 5, 0), task_3[:reminder])
  end

  def test_to_tasklist
    text = load_example('example_5')
    parser = Parser.new(text)
    tasklist = parser.to_tasklist
    task_1 = tasklist.tasks.first
    task_2 = tasklist.tasks.last

    assert_instance_of(Tasklist, tasklist)
    assert_equal(2, tasklist.tasks.length)
    assert_equal("Another List Another Day", tasklist.name)

    assert_equal('Yolo', task_1.name)
    assert(task_1.is_finished)
    assert_nil(task_1.date)

    assert_equal('Yolo in the house', task_2.name)
    assert(task_2.is_finished)
    assert_equal(Date.new(2015, 2, 16), task_2.date)

  end
end
