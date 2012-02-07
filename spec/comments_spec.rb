require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Bugzilla::Comment" do

  before(:all) do
    @klass = TicketMaster::Provider::Bugzilla::Comment
  end

  before(:each) do 
    VCR.use_cassette('init-tm-for-comments') { @ticketmaster = TicketMaster.new(:bugzilla, {:username => 'george.rafael@gmail.com', :password => '123456', :url => 'https://landfill.bugzilla.org/bugzilla-3.6-branch'}) }
    VCR.use_cassette('project-for-comment') { @project = @ticketmaster.project(20) }
    VCR.use_cassette('ticket-for-comment') { @ticket = @project.ticket(7039) }
  end

  it "should be able to load all comments from a ticket" do
    VCR.use_cassette('comments-all') { @comments = @ticket.comments }
    @comments.should be_an_instance_of(Array)
    @comments.first.should be_an_instance_of(@klass)
  end

  it "should be able to load all comments based on array of id's" do 
    VCR.use_cassette('comments-by-array') { @comments = @ticket.comments([18575]) }
    @comments.should be_an_instance_of(Array)
    @comments.first.should be_an_instance_of(@klass)
  end

  it "should be able to load a comment based on an id" do 
    VCR.use_cassette('comments-by-id') { @comment = @ticket.comment(18575) }
    @comment.should be_an_instance_of(@klass)
    @comment.id.should == 18575
  end
end
