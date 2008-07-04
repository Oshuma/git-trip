require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Painter do
  before(:each) do
    @commit  = Digest::SHA1.hexdigest('ruby')
    @painter = Painter.new(@commit)
  end

  it "should have access to Image" do
    Painter::Image.should be_a_kind_of(Class)
  end

  it "should instantiate" do
    @painter.should be_instance_of(Painter)
  end

  it "should raise Errors::InvalidSHA" do
    lambda { Painter.new('not a valid sha') }.should raise_error(Errors::InvalidSHA)
  end

  it "should raise Errors::RTFM" do
    lambda { Painter.new(5) }.should raise_error(Errors::RTFM)
  end

  it "should return an array of 5 RGB color codes" do
    @painter.colors.size.should eql(5)
  end

  it "should have 8 characters per color" do
    @painter.colors.each do |color|
      color.size.should eql(8)
    end
  end

  it "should have proper colors for it's SHA" do
    @painter.colors.join.should eql(@commit)
  end
end
