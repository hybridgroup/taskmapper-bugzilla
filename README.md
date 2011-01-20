# ticketmaster-bugzilla

This is a provider for [ticketmaster](http://ticketrb.com). It provides interoperability with [Bugzilla](http://bugzilla.org) and it's issue tracking system through the ticketmaster gem.

# Usage and Examples

First we have to instantiate a new ticketmaster instance, your bugzilla installation should have api access enable:
bugzilla = TicketMaster.new(:bugzilla, {:username=> 'foo', :password => "bar", :url => "https://bugzilla.mozilla.org"})

If you do not pass in the url, username and password, you won't get any information.

## Finding Projects(Products)

projects = ticketmaster.projects # All projects
projects = ticketmaster.projects([1,2,3]) # A list of projects based on id
project = ticketmaster.project(1) # Single project
project = ticketmaster.project(:id => 1) # Single project based on attributes

## Finding Tickets(Bugs)

tickets = project.tickets # All tickets
tickets = project.tickets([1,2,3]) # List of tickets based on id's
ticket = project.ticket(1) # Single ticket by id

## Open Tickets

ticket = project.ticket!({:summary => "New ticket", :description=> "Body for the very new ticket", :component => "Canvas", :op_sys =>"Linux", :platform => "x86", ... }) # You can add all the attributes for a valid ticket, but the one in th example are the mandatory ones. Here is the list of valid attributes
                  product_id
                  id 
                  component_id 
                  summary 
                  title 
                  version 
                  op_sys 
                  platform 
                  priority 
                  description 
                  alias 
                  qa_contact 
                  assignee 
                  status 
                  target_milestone 
                  severity 

## Finding comments

comments = project.tickets.first.comments # All the tickets facility for searchs are available for comments as well
comments = project.ticket(1).comments([1,2,3]) # List of comments based on id's


## Requirements

  * rubygems (obviously)
  * ticketmaster gem (latest version preferred)
  * jeweler gem (only if you want to repackage and develop)
  * guitsaru-rubyzilla

  The ticketmaster gem should automatically be installed during the installation of this gem if it is not already installed.

## Other Notes

  Since this and the ticketmaster gem is still primarily a work-in-progress, minor changes may be incompatible with previous versions. Please be careful about using and updating this gem in production.

  If you see or find any issues, feel free to open up an issue report.


## Note on Patches/Pull Requests

  * Fork the project.
  * Make your feature addition or bug fix.
  * Add tests for it. This is important so we don't break it in a
  future version unintentionally.
  * Commit, do not mess with rakefile, version, or history.
(if you want to have your own version, that is fine but bump version in a commit by itself so we can ignore when I pull)
  * Send us a pull request. Bonus points for topic branches.

## Copyright

  Copyright (c) 2010 The Hybrid Group. See LICENSE for details.

