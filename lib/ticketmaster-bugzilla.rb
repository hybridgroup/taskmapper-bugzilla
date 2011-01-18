require 'rubyzilla'

module Rubyzilla
  class Product
    def bugs(attributes = {})
      if attributes.empty?
        attributes.merge!(:last_change_time => Time.now-30*24*60*60)
      end
      attributes.merge!(:product => self.name, :limit => 100)
      result = Bugzilla.server.call("Bug.search", attributes)
      result["bugs"]
    end
  end

  class Bug
    def comments
      result = Bugzilla.server.call("Bug.comments", {:ids => [self.id]})
      result["bugs"]["#{self.id}"]["comments"]
    end
  end
end

%w{ bugzilla ticket project comment }.each do |f|
  require File.dirname(__FILE__) + '/provider/' + f + '.rb';
end

