module TicketMaster::Provider
  module Bugzilla
    # Ticket class for ticketmaster-bugzilla
    #
    
    class Ticket < TicketMaster::Provider::Base::Ticket
      # declare needed overloaded methods here
      TICKETS_API = Rubyzilla::Product
      def initialize(*object)
        return super(object.first) if object.first.is_a? Hash
        if object.first
          object = object.first
          unless object.is_a? Hash
            @system_data = {:client => object}
            hash = {:product_id => object.product_id,
              :id => object.id,
              :project_id => object.product_id,
              :component_id => object.component_id,
              :summary => object.summary,
              :title => object.summary,
              :version => object.version,
              :op_sys => object.op_sys,
              :platform => object.platform,
              :priority => object.priority,
              :description => object.description,
              :alias => object.alias,
              :qa_contact => object.qa_contact,
              :assignee => object.assigned_to,
              :requestor => object.qa_contact,
              :status => object.status,
              :target_milestone => object.target_milestone,
              :severity => object.severity,
              :created_at => nil,
              :updated_at => nil}
          else
            hash = object
          end
          super hash
        end
      end

      def title
        self[:summary]
      end

      def description
        self[:description]
      end

      def requestor
        self[:requestor]
      end

      def assignee
        self[:assignee]
      end

      def created_at
        begin
          normalize_datetime(self[:last_change_time])
        rescue
          self[:created_at]
        end
      end

      def updated_at
        begin
          normalize_datetime(self[:last_change_time])
        rescue
          self[:updated_at]
        end
      end

      def self.find_by_id(id)
        bug = Rubyzilla::Bug.new id
        self.new bug
      end

      def self.find(project_id, *options)
        if options.first.empty?
          TICKETS_API.new(project_id).bugs.collect { |bug| self.new bug }
        elsif options[0].first.is_a? Array
         options[0].first.collect { |bug_id| self.find_by_id bug_id }
        elsif options[0].first.is_a? Hash
          bugs = TICKETS_API.new(project_id).bugs.collect { |bug| self.new bug }
          search_by_attribute(bugs, options[0].first)
        end
      end

      def self.create(project_id, *options)
        begin
          bug = Rubyzilla::Bug.new   
          bug.product = TICKETS_API.new project_id
          options.first.each_pair do |k, v|
            bug.send "#{k}=", v
          end
          self.new bug.create
        rescue
          self.find(project_id, []).last
        end
      end

      def comments(*options)
        Comment.find(self.id, options)
      end

      def comment(*options)
        Comment.find_by_id(self.id, options.first)
      end

      private
      def normalize_datetime(datetime)
        Time.mktime(datetime.year, datetime.month, datetime.day, datetime.hour, datetime.min, datetime.sec)
      end

    end
  end
end
