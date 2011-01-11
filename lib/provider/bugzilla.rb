module TicketMaster::Provider
  # This is the Yoursystem Provider for ticketmaster
  module Bugzilla
    include TicketMaster::Provider::Base
    
    # This is for cases when you want to instantiate using TicketMaster::Provider::Yoursystem.new(auth)
    def self.new(auth = {})
      TicketMaster.new(:bugzilla, auth)
    end
    
    # declare needed overloaded methods here
    def authorize(auth = {})
      @authentication ||= TicketMaster::Authenticator.new(auth)
      auth = @authentication
      if (auth.username.nil? || auth.url.nil? || auth.password.nil?)
        raise "Please provide username, password and url"
      end
      BugzillaAPI.authenticate(auth.username, auth.password, auth.url)
    end

    def projects(*options)
      []
    end
    
  end
end
