require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe TaskMapper::Provider::Bugzilla::Project do

  before(:all) do 
    @core = {:id => 1, :name => 'Core'}
    @projects = [@core]
    @klass = TaskMapper::Provider::Bugzilla::Project
  end

  before(:each) do
    VCR.use_cassette('project-initialization') { @taskmapper = TaskMapper.new(:bugzilla, {:username => 'george.rafael@gmail.com', :password => '123456', :url =>'https://landfill.bugzilla.org/bugzilla-3.6-branch/'}) }
  end

  it "should be able to load all projects" do
    VCR.use_cassette('load-all-projects') { @projects = @taskmapper.projects }
    @projects.should be_an_instance_of(Array)
    @projects.first.should be_an_instance_of(@klass)
  end

  it "should be able to load projects using an array of id's" do
    VCR.use_cassette('projects-by-ids') { @projects = @taskmapper.projects([1,2,3]) }
    @projects.should be_an_instance_of(Array)
    @projects.first.should be_an_instance_of(@klass)
    @projects.first.name.should == 'WorldControl'
  end

  it "should be able to find a project by id" do
    VCR.use_cassette('projects-by-id') { @project = @taskmapper.project(1) }
    @project.should be_an_instance_of(@klass)
    @project.name.should == 'WorldControl'
  end

  it "should be able to load project using the find method" do
    VCR.use_cassette('project-by-find-method') { @project = @taskmapper.project.find(1) }
    @project.should be_an_instance_of(@klass)
    @project.name.should == 'WorldControl'
  end

end
