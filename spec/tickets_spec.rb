require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Bugzilla::Ticket" do

  before(:all) do 
    @klass = TicketMaster::Provider::Bugzilla::Ticket
    bug = {:id => 7039}
    Rubyzilla::Product.stub!(:bugs).and_return([bug])
    Rubyzilla::Bug.stub!(:create).and_return(bug)
  end

  before(:each) do 
    @ticketmaster = TicketMaster.new(:bugzilla, {:username => 'george.rafael@gmail.com', :password => '123456', :url =>'https://landfill.bugzilla.org/bugzilla-3.6-branch'})
    @project = @ticketmaster.project(1)
  end

  it "should be able to load all tickets" do 
    tickets = @project.tickets
    tickets.should be_an_instance_of(Array)
    tickets.first.should be_an_instance_of(@klass)
  end

  it "should be able to load all tickets from an array of id's" do 
    tickets = @project.tickets([7039])
    tickets.should be_an_instance_of(Array)
    tickets.first.should be_an_instance_of(@klass)
    tickets.first.id.should == 1
  end

  it "should be able to search tickets based on id attribute"  do
    tickets = @project.tickets(:id => 7039)
    tickets.should be_an_instance_of(Array)
    tickets.first.should be_an_instance_of(@klass)
  end

  it "should be able to search a ticket by id" do
    ticket = @project.ticket(7039)
    ticket.should be_an_instance_of(@klass)
    ticket.id.should == 7039
  end

  it "should be able to return a ticket by attributes" do
    ticket = @project.ticket(:id => 7039)
    ticket.should be_an_instance_of(@klass)
    ticket.id.should == 7039
  end

  it "should be able to create a ticket" do 
    ticket = @project.ticket!(:summary => "The program crashes", :description => "It crashes", :component => "EconomicControl", :op_sys => "Linux", :platform => "x86")
    ticket.should be_an_instance_of(@klass)
  end
end
