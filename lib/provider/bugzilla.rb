require 'taskmapper'

module TaskMapper::Provider
  # This is the Yoursystem Provider for taskmapper
  module Bugzilla
    include TaskMapper::Provider::Base
    PROJECT_API = Rubyzilla::Product
    
    # This is for cases when you want to instantiate using TaskMapper::Provider::Yoursystem.new(auth)
    def self.new(auth = {})
      TaskMapper.new(:bugzilla, auth)
    end
    
    # declare needed overloaded methods here
    def authorize(auth = {})
      @authentication ||= TaskMapper::Authenticator.new(auth)
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

    def project(*options)
      unless options.empty?
        Project.find(options.first)
      else
        super
      end
    end

  end
end
