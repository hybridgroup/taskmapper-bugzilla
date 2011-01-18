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
    def comments(attributes = {})
      unless attributes[:comments_id].empty?
        attributes.merge!(:ids => [self.id])
      end
      comments = []
      puts attributes.inspect
      result = Bugzilla.server.call("Bug.comments", attributes)
      if attributes.has_key? "ids"
        comments = result["bugs"]["#{self.id}"]["comments"]
      else
        comments = attributes[:comments_id].select { |comment_id| result["comments"]["#{comment_id}"] }
      end
      comments
    end
  end
end

%w{ bugzilla ticket project comment }.each do |f|
  require File.dirname(__FILE__) + '/provider/' + f + '.rb';
end

