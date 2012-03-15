$LOAD_PATH << './'
require 'csv'
require 'elements'
require 'data_parser'
require 'help'
require 'queue'
require 'search'

module EventReporter
  class Command  

  ALL_COMMANDS = {"load" => "loads a new csv data file. Usage is: [ load ] <file.csv>", 
                  "help" => "shows a list of available commands.  Usage is [ help ] <command>",
                  "queue count" => "returns the total number of the entries in the queue.  Usage is: [ queue count ] ", 
                  "queue clear" => "empties the current queue.  Usage is: [ queue clear ] ",
                  "queue print" => "prints the current queue. Usage is: [ queue print ] ", 
                  "queue print by" => "prints the current queue ordered by specified attribute.  Usage is: [ queue print by ] <attribute>",
                  "queue save to" => "exports queue to a CSV. Usage is: [ queue save to ] <file.csv>", 
                  "find" => "loads the queue with matching records. Usage is: [ find ] <attribute> <criteria> ",
                  "quit" => "quits the program. Usage is: [ quit ]", 
                  "q" => "quits the program. Usage is: [ q ]", 
                  "e" => "quits the program. Usage is: [ e ]", 
                  "exit" => "quits the program. Usage is: [ exit ]"}
    
    def self.valid?(command)
      ALL_COMMANDS.keys.include?(command)
    end

    def self.execute(command, parameters)
      if command == "load" && DataParser.valid_parameters_for_load?(parameters)
          DataParser.load(parameters[0])          
      elsif command == "queue" && Queue.valid_parameters_for_queue?(parameters)
          Queue.new.call(parameters)
      elsif command == "help" && Help.valid_parameters_for_help?(parameters)
          Help.for(parameters)
      elsif command == "find" && Search.valid_parameters_for_find?(parameters)
          Search.for(parameters)
      else 
        error_message_for(command)
      end
    end

    def self.error_message_for(command)
      puts "Command '#{command}' not recognized or the syntax is incorrect"
      puts "Please use a command: #{ALL_COMMANDS.keys.join(", ")}"
    end

  end
end