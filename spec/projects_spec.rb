require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Bugzilla::Project" do

  before(:all) do 
    @core = {:id => 1, :name => 'Core'}
    @projects = [@core]
    @klass = TicketMaster::Provider::Bugzilla::Project
  end

  before(:each) do
    VCR.use_cassette('project-initialization') { @ticketmaster = TicketMaster.new(:bugzilla, {:username => 'george.rafael@gmail.com', :password => '123456', :url =>'https://landfill.bugzilla.org/bugzilla-3.6-branch/'}) }
  end

  it "should be able to load all projects" do
    VCR.use_cassette('load-all-projects') { @projects = @ticketmaster.projects }
    @projects.should be_an_instance_of(Array)
    @projects.first.should be_an_instance_of(@klass)
  end

  it "should be able to load projects using an array of id's" do
    VCR.use_cassette('projects-by-ids') { @projects = @ticketmaster.projects([1,2,3]) }
    @projects.should be_an_instance_of(Array)
    @projects.first.should be_an_instance_of(@klass)
    @projects.first.name.should == 'WorldControl'
  end

  it "should be able to find a project by id" do
    VCR.use_cassette('projects-by-id') { @project = @ticketmaster.project(1) }
    @project.should be_an_instance_of(@klass)
    @project.name.should == 'WorldControl'
  end

  it "should be able to load project using the find method" do
    VCR.use_cassette('project-by-find-method') { @project = @ticketmaster.project.find(1) }
    @project.should be_an_instance_of(@klass)
    @project.name.should == 'WorldControl'
  end

  it "should be able to find by attributes" do 
    pending
    VCR.use_cassette('project-by-attributes') { @project = @ticketmaster.project.find(:first, {:name => 'Core'}) }
    @project.should be_an_instance_of(@klass)
  end

  it "should be able to find by an array of id's" do 
    VCR.use_cassette('project-by-find-with-ids') { @project = @ticketmaster.project.find(:all, [1,2]) }
    @project.should be_an_instance_of(Array)
    @project.first.should be_an_instance_of(@klass)
    @project.first.name.should == 'WorldControl'
  end

end
