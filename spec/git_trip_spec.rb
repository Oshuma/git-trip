require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe GitTrip do
  it "should return version string" do
    GitTrip::VERSION.should be_a_kind_of(String)
  end
end
