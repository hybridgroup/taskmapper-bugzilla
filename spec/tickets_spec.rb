require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Bugzilla::Ticket" do

  before(:all) do 
    @klass = TicketMaster::Provider::Bugzilla::Ticket
  end

  before(:each) do 
    @ticketmaster = TicketMaster.new(:bugzilla, {:username => 'george.rafael@gmail.com', :password => '123456', :url =>'https://bugzilla.mozilla.org'})
    @project = @ticketmaster.project(1)
  end

  it "should be able to load all tickets" do 
    tickets = @project.tickets
    tickets.should be_an_instance_of(Array)
    tickets.first.should be_an_instance_of(@klass)
  end

  it "should be able to load all tickets from an array of id's" do 
    tickets = @project.tickets([65845])
    tickets.should be_an_instance_of(Array)
    tickets.first.should be_an_instance_of(@klass)
    tickets.first.id.should == 65845
  end

  it "should be able to search tickets based on id attribute" 
end
