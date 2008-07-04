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

  it "should accept a custom image format" do
    Painter.new(@commit, :format => 'gif').should be_instance_of(Painter)
  end

  it "should create an image with the given RGB color code" do
    color = @commit.slice(0, 6)
    @painter.paint(color).should be_instance_of(Magick::Image)
  end

  it "should return an array of Magick::Image objects" do
    @painter.images.each { |image| image.should be_instance_of(Magick::Image) }
  end
end
