require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Painter do
  before(:each) do
    @commits = %w{
      ruby is fucking awesome word to your mother
    }.map { |text| Digest::SHA1.hexdigest(text) }
    @painter = Painter.new(@commits)
  end

  it "should instantiate" do
    @painter.should be_instance_of(Painter)
  end
  
  it "should default to a size of 5" do
    @painter.size.should eql(5)
  end
  
  it "should allow a custom size" do
    Painter.new(@commits, 3).size.should eql(3)
  end

  it "should raise NoCommits"
end
