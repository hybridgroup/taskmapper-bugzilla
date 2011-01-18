require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Bugzilla::Comment" do

  before(:all) do
    @klass = TicketMaster::Provider::Bugzilla::Comment
  end

  before(:each) do 
    @ticketmaster = TicketMaster.new(:bugzilla, {:username => 'rafael@hybridgroup.com', :password => '123456', :url => 'https://bugzilla.mozilla.org'})
    @project = @ticketmaster.project(1)
    @ticket = @project.ticket(65845)
  end

  it "should be able to load all comments from a ticket" do
    comments = @ticket.comments
    comments.should be_an_instance_of(Array)
    comments.first.should be_an_instance_of(@klass)
  end
end
