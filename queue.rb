$LOAD_PATH << './'
require 'csv'
require 'elements'
require 'data_parser'
require 'search'

module EventReporter
  
  class Queue

    OUTPUT_HEADERS = ["regdate", "first_name", "last_name", "email_address", "homephone", "street", "city", "state", "zipcode"]

    def initialize
      if Search.results == []
        @@current_queue = []
      else
        @@current_queue = @@current_queue
      end
    end

    def self.current_queue
      @@current_queue
    end

    def self.current_queue=(search_results)
      @@current_queue = search_results
    end
    
    def call(params)

      if params[0] == "count" 
        puts "Number of entries in queue: #{@@current_queue.size}"

      elsif params[0] == "clear"
        puts "Clearing your queue."
        Search.new 
        @@current_queue = []

      elsif params[1] == "by" && params[0] == "print"
        print_by(params[2])

      elsif params[0] == "print"
        print_by("regdate")

      elsif params[0] == "save"
        filename = params[2]
        output = CSV.open(filename, "w") do |output|
          output <<  OUTPUT_HEADERS
          @@current_queue.each do |line|
            output << [line.regdate, line.first_name, line.last_name, line.email_address, line.homephone, line.street, line.city, line.state, line.zipcode]
          end
        end
        puts "Data written to output file"

      end
    end

    def print_by(sorting_parameter)
    puts "LAST NAME".ljust(16) + 
         "FIRST NAME".ljust(20) + 
         "EMAIL".ljust(40) + 
         "ZIPCODE".ljust(20) + 
         "CITY".ljust(24) + 
         "STATE".ljust(20) + 
         "ADDRESS"
    @@current_queue = @@current_queue.sort_by{|line| line.send(sorting_parameter).to_sym}
    @@current_queue.each do |line|
      puts "#{line.last_name}".capitalize.ljust(16) + 
           "#{line.first_name}".capitalize.ljust(20) + 
           "#{line.email_address}".capitalize.ljust(40) + 
           "#{line.zipcode}".capitalize.ljust(20) + 
           "#{line.city}".capitalize.ljust(24) + 
           "#{line.state}".upcase.ljust(20) + 
           "#{line.street}"   
        end 
    end

    def self.valid_parameters_for_queue?(parameters)
      if !%w(count clear print save).include?(parameters[0])
        false
      elsif parameters[0] == "print" 
        parameters.count == 1 || (parameters[1] == "by" && parameters.count == 3 )
      elsif parameters[0] == "save"
        parameters[1] == "to" && parameters.count == 3
      else
        true
      end
    end

  end
end