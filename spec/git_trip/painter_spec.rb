require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Painter do
  before(:each) do
    @commit  = Digest::SHA1.hexdigest('ruby')
    @painter = Painter.new(@commit)
  end

  it "should raise Errors::InvalidSHA" do
    lambda { Painter.new('not a valid sha') }.should raise_error(Errors::InvalidSHA)
  end

  it "should raise Errors::InvalidStyle" do
    lambda do
      Painter.new(@commit, :style => 'invalid')
    end.should raise_error(Errors::InvalidStyle)
  end

  it "should raise Errors::RTFM" do
    lambda { Painter.new(5) }.should raise_error(Errors::RTFM)
  end

  it "should have access to Image" do
    Painter::Image.should be_a_kind_of(Class)
  end

  it "should instantiate" do
    @painter.should be_instance_of(Painter)
  end

  it "should build a canvas" do
    @painter.canvas.should be_instance_of(Magick::ImageList)
  end

  it "should set default width" do
    options = @painter.instance_variable_get(:@options)
    options[:width].should eql(50)
  end

  it "should allow a custom width" do
    @painter = Painter.new(@commit, :width => 25)
    options = @painter.instance_variable_get(:@options)
    options[:width].should eql(25)
  end

  it "should set default height" do
    options = @painter.instance_variable_get(:@options)
    options[:height].should eql(50)
  end

  it "should allow a custom height" do
    @painter = Painter.new(@commit, :height => 25)
    options = @painter.instance_variable_get(:@options)
    options[:height].should eql(25)
  end

  it "should set default style" do
    options = @painter.instance_variable_get(:@options)
    options[:style].should eql('montage')
  end

  it "should allow a vertical style" do
    @painter = Painter.new(@commit, :style => 'vertical')
    options = @painter.instance_variable_get(:@options)
    options[:style].should eql('vertical')
  end

  it "should allow a montage style" do
    @painter = Painter.new(@commit, :style => 'montage')
    options = @painter.instance_variable_get(:@options)
    options[:style].should eql('montage')
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

  it "should accept a custom size" do
    Painter.new(@commit, :size => [25, 25]).should be_instance_of(Painter)
  end

  it "should paint a montage image (list)" do
    @painter.paint!.should_not be_false
    @painter.picture.should be_instance_of(Magick::ImageList)
  end

  it "should paint a horizontal image" do
    @painter = Painter.new(@commit, :style => 'horizontal')
    @painter.paint!.should_not be_false
    @painter.picture.should be_instance_of(Magick::Image)
  end

  it "should paint a vertical image" do
    @painter = Painter.new(@commit, :style => 'vertical')
    @painter.paint!.should_not be_false
    @painter.picture.should be_instance_of(Magick::Image)
  end
end
