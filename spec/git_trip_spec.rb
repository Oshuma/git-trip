require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe GitTrip do
  it "should return version string" do
    GitTrip::VERSION.should be_a_kind_of(String)
  end

  it "should include Exceptions" do
    GitTrip::Errors.should be_a_kind_of(Module)
  end

  it "should include Gitter" do
    GitTrip::Gitter.should be_a_kind_of(Class)
  end
end
