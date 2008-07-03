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

  it "should return size of commits" do
    @painter.size.should eql(@commits.size)
  end

  it "should iterate the commits" do
    @painter.each_commit do |c|
      c.should be_instance_of(String)
      c.size.should eql(40) # size of a SHA1
    end
  end

  it "should raise ArgumentError" do
    lambda { Painter.new }.should raise_error(ArgumentError)
  end

  it "should raise Errors::NoCommits" do
    lambda { Painter.new(nil) }.should raise_error(Errors::NoCommits)
  end
end
