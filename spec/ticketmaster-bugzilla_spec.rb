require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Bugzilla" do
  
  before(:each) do 
    @ticketmaster = TicketMaster.new(:bugzilla, {:username => 'george.rafael@gmail.com', :password => '123456', :url => 'https://landfill.bugzilla.org/bugzilla-3.6-branch'})
  end

  it "should be able to instantiate a new instance" do
    @ticketmaster.should be_an_instance_of(TicketMaster)
    @ticketmaster.should be_a_kind_of(TicketMaster::Provider::Bugzilla)
  end

  it "should be able to validate it's authentication" do 
    pending
    @ticketmaster.valid?.should be_true
  end

end
