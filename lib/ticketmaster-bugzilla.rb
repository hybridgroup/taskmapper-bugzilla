require 'rubyzilla'

module Rubyzilla
  class Product
    def bugs(limit = 100)
      result = Bugzilla.server.call("Bug.search", {:product => self.name, :last_change_time => Time.now-30*24*60*60, :limit => limit})
      result["bugs"]
    end
  end
end

%w{ bugzilla ticket project comment }.each do |f|
  require File.dirname(__FILE__) + '/provider/' + f + '.rb';
end

