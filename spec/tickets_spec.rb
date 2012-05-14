require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe TaskMapper::Provider::Bugzilla::Ticket do

  before(:all) do 
    @klass = TaskMapper::Provider::Bugzilla::Ticket
    bug = {:id => 7039}
  end

  before(:each) do 
    VCR.use_cassette('taskmapper-instance') { @taskmapper = TaskMapper.new(:bugzilla, :username => 'george.rafael@gmail.com', :password => '123456', :url =>'https://landfill.bugzilla.org/bugzilla-3.6-branch') }
    VCR.use_cassette('loading-a-project') { @project = @taskmapper.project(20) }
  end

  it "should be able to load all tickets" do 
    VCR.use_cassette('load-all-tickets') { @tickets = @project.tickets }
    @tickets.should be_an_instance_of(Array)
    @tickets.first.should be_an_instance_of(@klass)
  end

  it "should be able to load all tickets from an array of id's" do 
    VCR.use_cassette('load-tickets-by-ids') { @tickets = @project.tickets([7039]) }
    @tickets.should be_an_instance_of(Array)
    @tickets.first.should be_an_instance_of(@klass)
    @tickets.first.id.should == 7039
  end

  it "should be able to search tickets based on id attribute"  do
    VCR.use_cassette('load-by-attributes') { @tickets = @project.tickets(:project_id => 20) }
    @tickets.should be_an_instance_of(Array)
    @tickets.first.should be_an_instance_of(@klass)
  end

  it "should be able to search a ticket by id" do
    VCR.use_cassette('load-by-id') { @ticket = @project.ticket(7039) }
    @ticket.should be_an_instance_of(@klass)
    @ticket.id.should == 7039
  end

  it "should be able to create a ticket" do 
    VCR.use_cassette('create-a-ticket') { @ticket = @project.ticket!(:summary => "The program crashes", :description => "It crashes", :component => "EconomicControl", :op_sys => "Linux", :platform => "x86") }
    @ticket.should be_an_instance_of(@klass)
  end
end
