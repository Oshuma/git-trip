require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe GitTrip do
  it "should return version string" do
    GitTrip::VERSION.should be_a_kind_of(String)
  end

  it "should include Grit" do
    Grit.should be_a_kind_of(Module)
  end

  it "should include Magick" do
    Magick.should be_a_kind_of(Module)
  end

  it "should include Errors" do
    GitTrip::Errors.should be_a_kind_of(Module)
  end

  it "should include Gitter" do
    GitTrip::Gitter.should be_a_kind_of(Module)
  end
end
