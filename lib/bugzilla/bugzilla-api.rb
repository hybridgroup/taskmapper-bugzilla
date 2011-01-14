module Rubyzilla
  class Product
    def bugs
      result = Bugzilla.server.call("Bugs.search", {:product => self.name, :last_change_time => Time.now-30*24*60*60})
      result["bugs"]
    end
  end
end
