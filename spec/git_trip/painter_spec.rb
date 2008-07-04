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

  it "should return an array of 6 RGB color codes" do
    @painter.colors.size.should eql(6)
  end

  it "should have 6 characters per color" do
    @painter.colors.each do |color|
      color.size.should eql(6)
    end
  end

  it "should have proper colors for it's SHA and remaining 4 characters" do
    sha = @painter.colors.to_s + @commit[-4, 4]
    sha.should eql(@commit)
  end

  it "should accept a custom format" do
    Painter.new(@commit, :format => 'gif').should be_instance_of(Painter)
  end

  it "should accept a custom size" do
    Painter.new(@commit, :size => [25, 25]).should be_instance_of(Painter)
  end

  it "should paint an image with it's colors" do
    @painter.paint!.should_not be_false
    @painter.canvas.should be_instance_of(Magick::ImageList)
  end
end
