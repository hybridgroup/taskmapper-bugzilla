require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "TaskMapper::Provider::Bugzilla" do
  
  before(:each) do 
    VCR.use_cassette('tm-authentication') { @taskmapper = TaskMapper.new(:bugzilla, {:username => 'george.rafael@gmail.com', :password => '123456', :url => 'https://landfill.bugzilla.org/bugzilla-3.6-branch'}) }
  end

  it "should be able to instantiate a new instance" do
    @taskmapper.should be_an_instance_of(TaskMapper)
    @taskmapper.should be_a_kind_of(TaskMapper::Provider::Bugzilla)
  end

  it "should be able to validate it's authentication" do 
    @taskmapper.valid?.should be_true
  end

end
