$LOAD_PATH << './'
require 'command'
require 'search'
require 'data_parser'

module EventReporter
  class CLI

  EXIT_COMMANDS = ["quit", "q", "e", "exit"]

  Search.new
  DataParser.new
  Queue.new

    def self.parse_user_input(input)
      [ input.first.downcase, input[1..-1] ]
    end


    def self.prompt_user
      printf "enter command > "
      inputs = gets.strip.split
    end


    def self.run
      puts "Welcome to the EventReporter"
      command = ""

      until EXIT_COMMANDS.include?(command)
        inputs = prompt_user

        if inputs.any?
          command, parameters = parse_user_input(inputs)
          Command.execute(command, parameters) unless quitting?(command)
        else
          puts "No command entered."
        end
      end
      puts "Goodbye!"
    end

    def self.quitting?(command)
      EXIT_COMMANDS.include?(command)
    end
  end
end

EventReporter::CLI.run