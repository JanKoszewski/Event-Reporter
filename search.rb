require 'data_parser'
require 'elements'
require 'queue'

$LOAD_PATH << './'

module EventReporter
  class Search

    attr_accessor :results

    def initialize
      @@results = []
    end

    def self.results
      @@results
    end

    def self.for(parameters)

      attribute = parameters[0]
      criteria = parameters[1..-1].join(" ")

      @@results = []
      if DataParser.loaded_data.empty?
        puts "No data has been loaded. Please load data using the [ load ] command."
      else

        DataParser.loaded_data.select do |dataline|
          if dataline.respond_to?(attribute.to_sym) && dataline.send(attribute.to_sym).downcase == criteria.downcase
            @@results << dataline
          end
        end

        if @@results.size >= 1
           Queue.current_queue = @@results
           puts "Seach results loaded to the queue."
        else 
            puts "No search results matched your criteria"
        end
      end
      
    end

    def self.valid_parameters_for_find?(parameters)
      parameters.count > 1
    end
  end
end