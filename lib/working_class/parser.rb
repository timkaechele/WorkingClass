require 'date'

module WorkingClass
  # The actual syntax parser
  #
  class Parser

    # Initialzes a new Parser instance
    # 
    # @param string [String] the WorkingClass syntax string
    # @param options [Hash] parser options
    #
    # @return [WorkingClass::Parser] a Parser instance
    def initialize(string, options = {})
      @raw_content = string
      # @todo define options
    end

    # Parses the syntax and returns it as an Hash
    #
    # @return [Hash] the parsed tasklist
    def to_h
    end

    # Parses the syntax and returns it as an WorkingClass::Todolist
    #
    # @return [WorkingClass::Tasklist] the parsed tasklist
    def to_tasklist
    end

    private

  end
end

