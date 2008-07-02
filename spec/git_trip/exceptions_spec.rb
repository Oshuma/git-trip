require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Exceptions do
  it "should define the helpful method" do
    Exceptions::Exception.should respond_to(:helpful)
  end

  it "should define InvalidFormat" do
    Exceptions::InvalidFormat.should be_a_kind_of(Class)
  end

  it "should define RTFM" do
    Exceptions::RTFM.should be_a_kind_of(Class)
  end
end
