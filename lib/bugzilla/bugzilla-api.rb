require 'rubygems'
require 'bugzilla'

module BugzillaAPI
  class << self
    attr_accessor :username, :password, :url

    def authenticate(username, password, url)
      @url = URI.parse(url)
      @host = @url.host
      @port = @url.port
      @path = @url.path
      @rbugzilla = ::Bugzilla::XMLRPC.new(@host, @port, @path)
    end

  end


  class Project
    def self.find(*options)
      []
    end
  end
end
