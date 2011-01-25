require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Bugzilla::Comment" do

  before(:all) do
    @klass = TicketMaster::Provider::Bugzilla::Comment
  end

  before(:each) do 
    @ticketmaster = TicketMaster.new(:bugzilla, {:username => 'george.rafael@gmail.com', :password => '123456', :url => 'https://landfill.bugzilla.org/bugzilla-3.6-branch'})
    @project = @ticketmaster.project(1)
    @ticket = @project.ticket(7039)
  end

  it "should be able to load all comments from a ticket" do
    comments = @ticket.comments
    comments.should be_an_instance_of(Array)
    comments.first.should be_an_instance_of(@klass)
  end

  it "should be able to load all comments based on array of id's" do 
    comments = @ticket.comments([18575])
    comments.should be_an_instance_of(Array)
    comments.first.should be_an_instance_of(@klass)
  end

  it "should be able to load a comment based on an id" do 
    comment = @ticket.comment(18575)
    comment.should be_an_instance_of(@klass)
    comment.id.should == 18575
  end
end
