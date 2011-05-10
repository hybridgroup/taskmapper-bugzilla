require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Bugzilla::Project" do

  before(:all) do 
    @core = {:id => 1, :name => 'Core'}
    @projects = [@core]
    @klass = TicketMaster::Provider::Bugzilla::Project
  end

  before(:each) do
    @ticketmaster = TicketMaster.new(:bugzilla, {:username => 'george.rafael@gmail.com', :password => '123456', :url =>'https://landfill.bugzilla.org/bugzilla-3.6-branch/'})
    Rubyzilla::Product.stub!(:list).and_return(@projects)
  end

  it "should be able to load all projects" do
    @ticketmaster.projects.should be_an_instance_of(Array)
    @ticketmaster.projects.first.should be_an_instance_of(@klass)
  end

  it "should be able to load projects using an array of id's" do
    projects = @ticketmaster.projects([1,2,3])
    projects.should be_an_instance_of(Array)
    projects.first.should be_an_instance_of(@klass)
    projects.first.name.should == 'WorldControl'
  end

  it "should be able to find a project by id" do
    project = @ticketmaster.project(1)
    project.should be_an_instance_of(@klass)
    project.name.should == 'WorldControl'
  end

  it "should be able to load project using the find method" do
    project = @ticketmaster.project.find(1)
    project.should be_an_instance_of(@klass)
    project.name.should == 'WorldControl'
  end

  it "should be able to find by attributes" do 
    project = @ticketmaster.project.find(:first, {:name => 'Core'})
    project.should be_an_instance_of(@klass)
    project.name.should == 'Core'
  end

  it "should be able to find by an array of id's" do 
    project = @ticketmaster.project.find(:all, [1,2])
    project.should be_an_instance_of(Array)
    project.first.should be_an_instance_of(@klass)
    project.first.name.should == 'Core'
  end

end
