# WorkingClass [![Build Status](https://travis-ci.org/TimKaechele/WorkingClass.svg)](https://travis-ci.org/TimKaechele/WorkingClass)

WorkingClass is an human readable syntax to write tasklists.
Besides being easy to read it's fully parseable, so you can work with the tasks
in Ruby.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'working_class'
```

And then execute:

```sh
$ bundle
```

Or install it yourself as:

```sh
$ gem install working_class
```

## Usage

### The Syntax

Keep in mind that all dates are formatted like this: `DD.MM.YYYY` or `D.M.YY`

```
Tasklist Name
---
[ ] My first task
[X] A finished task
[ ]{1.1.15} A task with a due date
[ ]{1.1.15}(31.1.15 12:00) A task with a date and a reminder
[ ]{1.1.15}(-1 12:00) A task with a date and a »relative« reminder
[ ]{1.1.15}(12:00) A task that will remind me at 12:00 1.1.15
```

You see it's pretty easy to write tasks like this.

At the moment the order of date and reminder is mandatory.

So you **can't** write:

```
My Tasklist
---
[ ](REMINDER){DATE} My Task
```


#### Tasklist Names

A tasklist name is written like this:

The `---` is important, don't forget it.

Every tasklist should have a name.

```
Tasklist Name
---
…
```

#### Unfinished Tasks

Both tasks are equal, they are both not finished.

We recommend the `[ ]`, it looks much nicer.

```
Shopping List
---
[ ] Jeans
[] T-Shirts
```

#### Finished Tasks

```
Groceries List
---
[X] Milk
[x] Bread
```

To write a finished task you have to write a `[X]` or `[x]`. It's not important
whether you write a small x or a capital X, both characters are recognized as
a finished task.


#### Tasks with a Date

It doesn't matter if you write your dates DD.MM.YY or D.M.YY or DD.MM.YYYY
WorkingClass accepts all of those formats, as long as it is a valid date.


```
The Party List
---
[X]{6.2.2015} Birthday Party
[X]{13.2.15} Another Birthday Party
```

#### Tasks with a Reminder

Every task can have a reminder.
You have several options when adding a reminder.

All times are 24h.

You can write a full date without a time and the parser will add the default
time (9:00) automatically.

```
An even more awesome Party List
---
[ ](31.1.15) This time of year
```

If you already specified a date for the task you can use a relative reminder
by writing `-2`, this specifies that you want to be reminded 2 days earlier.
The parser will add the default time, if you didn't add one.

```
The after party
---
[ ]{2.1.15}(-2) You will have to clean up everthing.
```

**Important:** This only works if your task has already a date.

This will not work:

```
The after party
---
[ ](-2) You will have to clean up everthing.
```

So enough of that, what about the times. You can easily add a time to your
reminder

```
My Finals
---
[ ]{26.1.15}(15:00) English
```

If you don't specify a relative or absolute date you will be reminded at 15:00
on the same day.


You can also combine absolute or relative dates with a time

```
My Finals
---
[ ]{26.1.15}(24.1.15 9:00) Don't panic.
[ ]{26.1.15}(-1 15:00) English
```

### The Parser

Check out the [full documentation](http://www.rubydoc.info/github/TimKaechele/WorkingClass/master)

```ruby
require 'working_class'

string = """
My Finals
---
[ ]{26.1.15}(15:00) English
"""

WorkingClass.load(string) # => WorkingClass::Tasklist

# or if you have a file
WorkingClass.load_file('./examples/example_1.txt') # => WorkingClass::Tasklist

```

## Contributing

1. Fork it ( https://github.com/TimKaechele/workingclass/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
