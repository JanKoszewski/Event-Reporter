module EventReporter

  class Element
    
    attr_accessor :dirty_regdate, :dirty_first_name, :dirty_last_name, :dirty_email_address, :dirty_homephone, :dirty_street, :dirty_city, :dirty_state, :dirty_zipcode

    def initialize(attributes = {})
      self.dirty_regdate        = attributes[:regdate]
      self.dirty_first_name     = attributes[:first_name]
      self.dirty_last_name      = attributes[:last_name]
      self.dirty_email_address  = attributes[:email_address]
      self.dirty_homephone      = attributes[:homephone]
      self.dirty_street         = attributes[:street]
      self.dirty_city           = attributes[:city]
      self.dirty_state          = attributes[:state]
      self.dirty_zipcode        = attributes[:zipcode]
    end

    def regdate
      RegDate.clean(self.dirty_regdate)
    end

    def first_name
      First_Name.clean(self.dirty_first_name)
    end

    def last_name
      Last_Name.clean(self.dirty_last_name)
    end

    def email_address
      Email_Address.clean(self.dirty_email_address)
    end

    def homephone
      PhoneNumber.new(self.dirty_homephone)
    end

    def street
      Street.clean(self.dirty_street)
    end

    def city
      City.clean(self.dirty_city)
    end

    def state
      State.clean(self.dirty_state)
    end

    def zipcode
      Zipcode.clean(self.dirty_zipcode)
    end

  end

  class RegDate
    def self.clean(dirty_regdate)
      dirty_regdate.to_s
    end
  end

  class First_Name
    def self.clean(dirty_first_name)
      dirty_first_name.to_s.downcase
    end
  end

  class Last_Name
    def self.clean(dirty_last_name)
      dirty_last_name.to_s.downcase
    end
  end

  class Email_Address
    def self.clean(dirty_email_address)
      dirty_email_address.to_s.downcase
    end
  end

  class PhoneNumber
    def initialize(dirty_homephone)
      @homephone = dirty_homephone.scan(/\d/).join
    end

    def to_s
      "(#{@homephone[0..2]}) #{@homephone[3..5]} - #{@homephone[6..-1]}"
    end

  end

  class Street
    def self.clean(dirty_street)
      dirty_street.to_s
    end
  end

  class City
    def self.clean(dirty_city)
      dirty_city.to_s.downcase
    end
  end

  class State
    def self.clean(dirty_state)
      dirty_state.to_s.downcase
    end
  end

  class Zipcode
    def self.clean(dirty_zipcode)
      dirty_zipcode.to_s.rjust(5, '0')
    end
  end

end