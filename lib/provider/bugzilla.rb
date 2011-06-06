require 'ticketmaster'

module TicketMaster::Provider
  # This is the Yoursystem Provider for ticketmaster
  module Bugzilla
    include TicketMaster::Provider::Base
    PROJECT_API = Rubyzilla::Product
    
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
      url = auth.url.gsub(/\/$/,'')
      unless url.split('/').last == 'xmlrpc.cgi'
        auth.url = url+'/xmlrpc.cgi'
      end
      @bugzilla = Rubyzilla::Bugzilla.new(auth.url)
      begin
        @bugzilla.login(auth.username,auth.password)
      rescue
        warn 'Authentication was invalid'
      end
    end

    def valid?
      Rubyzilla::Bugzilla.logged_in?
    end

    def projects(*options)
      if options.empty?
        PROJECT_API.list.collect { |product| Project.new product }
      elsif options.first.is_a? Array
        options.first.collect { |id| Project.find(id) }
      elsif options.first.is_a? Hash
        Project.find_by_attributes(options)
      end
    end

    def project(*options)
      unless options.empty?
        Project.find(options.first)
      else
        super
      end
    end

  end
end
