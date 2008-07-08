require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PaintMode do
  before(:each) do
    @image = Magick::Image.new(5, 5)
    @mode  = PaintMode.new(@image, :blend)
  end

  it "should instantiate" do
    @mode.should be_instance_of(PaintMode)
  end

  it "should raise ArgumentError" do
    lambda { PaintMode.new }.should raise_error(ArgumentError)
  end

  it "should raise Errors::InvalidPicture" do
    lambda do
      PaintMode.new('not a picture', :blend)
    end.should raise_error(Errors::InvalidPicture)
  end

  it "should raise Errors::InvalidMode" do
    lambda do
      PaintMode.new(@image, :invalid_mode)
    end.should raise_error(Errors::InvalidMode)
  end

  it "should allow mode as symbol" do
    PaintMode.new(@image, :blend).should be_instance_of(PaintMode)
  end

  it "should allow mode as string" do
    PaintMode.new(@image, 'blend').should be_instance_of(PaintMode)
  end

  it "should define MODES" do
    PaintMode::MODES.should be_instance_of(Array)
  end

  it "should have a picture accessor" do
    @mode.picture.should be_instance_of(Magick::Image)
  end
  
  it "should blend" do
    PaintMode.new(@image, :blend).picture.should be_instance_of(Magick::Image)
  end
  
  it "should pixel" do
    PaintMode.new(@image, :pixel).picture.should be_instance_of(Magick::Image)
  end

  it "should radial" do
    PaintMode.new(@image, :radial).picture.should be_instance_of(Magick::Image)
  end
end
