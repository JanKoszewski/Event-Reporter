$LOAD_PATH << './'
require 'csv'
require 'elements'

module EventReporter

  class DataParser

  CSV_OPTIONS = {:headers => true, :header_converters => :symbol}

    def initialize
      @@loaded_data = []
    end

    def self.loaded_data
      @@loaded_data
    end

    def self.valid_parameters_for_load?(parameters)
      parameters[0] =~ /\.csv$/ || parameters[0].nil?
    end

    def self.load(filename, options = CSV_OPTIONS)
      if filename.nil?
        filename = "event_attendees.csv"
      end
      file = (CSV.open(filename, options))
      loading_data(file)
    end

    def self.loading_data(file)
      file.rewind
      @@loaded_data = file.collect { |line| Element.new(line) }
      puts "Data loaded"
    end
  end
end