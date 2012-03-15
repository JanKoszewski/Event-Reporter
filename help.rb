$LOAD_PATH << './'

module EventReporter
  class Help

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

    def self.for(parameters)
      if parameters == []
        puts "'help' uses the syntax 'help' <command> to print information about each command.  Available commands are:"
        puts "#{ALL_COMMANDS.keys.join(", ")}"
      else
        puts "#{parameters.join(" ")}: " + ALL_COMMANDS[parameters.join(" ")]
      end
    end

    def self.valid_command?(command)
      ALL_COMMANDS.keys.include?(command)
    end

    def self.valid_parameters_for_help?(parameters)
      parameters.empty? || valid_command?(parameters.join(" "))
    end

  end
end