require 'working_class/version'
require 'working_class/parser'
require 'working_class/task'
require 'working_class/tasklist'

# WorkingClass Module
#
module WorkingClass

  # Loads the file from the path and returns a Tasklist
  #
  # @param path [String] the filepath
  # @return [WorkingClass::Tasklist] the parsed Tasklist
  #
  def self.load_file(path)
    string = File.open(path, 'r').read()
    self.load(string)
  end

  # Parses the given string and returns a Tasklist
  #
  # @param string [String] the WorkingClass tasklist syntax string
  # @return [WorkingClass::Tasklist] the parsed Tasklist
  #
  def self.load(string)
    Parser.new(string).to_tasklist
  end

end
