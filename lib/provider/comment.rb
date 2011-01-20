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

      def created_at
        begin
          normalize_datetime(self[:created_at])
        rescue
          self[:created_at]
        end
      end

      def updated_at
        begin
          normalize_datetime(self[:updated_at])
        rescue
          self[:updated_at]
        end
      end

      def self.find_by_id(ticket_id, id)
        self.new COMMENT_API.new(ticket_id).comments(:comment_ids => [id]).first
      end

      def self.find(ticket_id, *options)
        if options.first.empty?
          COMMENT_API.new(ticket_id).comments.collect { |comment| self.new comment }
        elsif options[0].first.is_a? Array
           COMMENT_API.new(ticket_id).comments(:comment_ids => options[0].first).collect { |comment| self.new comment }
        end
      end

      private
      def normalize_datetime(datetime)
        Time.mktime(datetime.year, datetime.month, datetime.day, datetime.hour, datetime.min, datetime.sec)
      end

    end
  end
end
