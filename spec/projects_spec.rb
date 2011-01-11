require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Bugzilla::Project" do

  before(:each) do
    @ticketmaster = TicketMaster.new(:bugzilla, {:username => 'george.rafael@gmail.com', :password => '', :url => 'http://mozilla.bugzilla.org'})
    @klas = TicketMaster::Provider::Bugzilla::Project
  end

  it "should be able to load all projects" do
    @ticketmaster.projects.should be_an_instance_of(Array)
    @ticketmaster.projects.first.should be_an_instance_of(@klass)
  end
end
