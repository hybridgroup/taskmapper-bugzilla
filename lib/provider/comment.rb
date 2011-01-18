module TicketMaster::Provider
  module Bugzilla
    # The comment class for ticketmaster-bugzilla
    #
    # Do any mapping between Ticketmaster and your system's comment model here
    # versions of the ticket.
    #
    COMMENT_API = Rubyzilla::Bug
    class Comment < TicketMaster::Provider::Base::Comment
      # declare needed overloaded methods here
      def initialize(*object) 
        if object.first
          object = object.first
          unless object.is_a? Hash
            @system_data = {:client => object}
            hash = {:id => object.id,
                    :ticket_id => object.bug_id,
                    :body => object.text,
                    :author => object.creator,
                    :created_at => object.time,
                    :updated_at => object.time}

          else
            hash = object
          end
          super hash
        end
      end

      def self.find(ticket_id, *options)
        if options.empty?
          COMMENT_API.new(ticket_id).comments.collect { |comment| self.new comment }
        elsif options[0].first.is_a? Array
          COMMENT_API.new(ticket_id).comments(:comments_id => options[0].first).collect { |comment| self.new comment }
        end
      end
    end
  end
end
