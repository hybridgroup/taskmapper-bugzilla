require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Bugzilla::Project" do

  before(:all) do 
    @project_name = 'Core'
    @klass = TicketMaster::Provider::Bugzilla::Project
  end

  before(:each) do
    @product = Factory.build(:product)
    @projects = [@product]
    @ticketmaster = TicketMaster.new(:bugzilla, {:username => 'george.rafael@gmail.com', :password => '123456', :url => 'https://bugzilla.mozilla.org'})
  end

  it "should be able to load all projects" do
    Rubyzilla::Product.stub!(:list).and_return(@projects)
    @ticketmaster.projects.should be_an_instance_of(Array)
    @ticketmaster.projects.first.should be_an_instance_of(@klass)
  end

  it "should be able to load projects using an array of id's" do
    projects = @ticketmaster.projects([1,2,3])
    projects.should be_an_instance_of(Array)
    projects.first.should be_an_instance_of(@klass)
    projects.first.name.should == 'Core'
  end

  it "should be able to find a project by id" do
    project = @ticketmaster.project(1)
    project.should be_an_instance_of(@klass)
    project.name.should == 'Core'
  end

  it "should be able to load project using the find method" do
    project = @ticketmaster.project.find(1)
    project.should be_an_instance_of(@klass)
    project.name.should == 'Core'
  end

  it "should be able to find by attributes" do 
    project = @ticketmaster.project.find(:first, {:name => 'Core'})
    project.should be_an_instance_of(@klass)
    project.name.should == 'Core'
  end

end
