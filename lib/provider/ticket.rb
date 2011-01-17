module TicketMaster::Provider
  module Bugzilla
    # Ticket class for ticketmaster-bugzilla
    #
    
    class Ticket < TicketMaster::Provider::Base::Ticket
      # declare needed overloaded methods here
      TICKETS_API = Rubyzilla::Product
      def initialize(*object)
        object = object.first
        @system_data = {:client => object}
        unless object.is_a? Hash
          hash = {:product_id => object.product_id,
                  :id => object.id,
                  :component_id => object.component_id,
                  :summary => object.summary,
                  :version => object.version,
                  :op_sys => object.op_sys,
                  :platform => object.platform,
                  :priority => object.priority,
                  :description => object.description,
                  :alias => object.alias,
                  :qa_contact => object.qa_contact,
                  :status => object.status,
                  :target_milestone => object.target_milestone,
                  :severity => object.severity}
        else
          hash = object
        end
        super hash
      end

      def self.find_by_id(id)
        self.new Rubyzilla::Bug.new id
      end

      def self.find(project_id, *options)
        if options.first.empty?
          TICKETS_API.new(project_id).bugs.collect { |bug| self.new bug }
        elsif options.first.is_a? Array
          TICKETS_API.new(project_id).bugs.collect { |bug| self.new bug }         
        elsif options[0].first.is_a? Hash
          TICKETS_API.new(project_id).bugs(options[0].first).collect { |bug| self.new bug }
        end
      end

    end
  end
end
