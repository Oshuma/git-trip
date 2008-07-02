require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Errors do
  it "should define DirNotFound" do
    Errors::DirNotFound.should be_a_kind_of(Class)
  end

  it "should define InvalidFormat" do
    Errors::InvalidFormat.should be_a_kind_of(Class)
  end

  it "should define InvalidGitRepo" do
    Errors::InvalidGitRepo.should be_a_kind_of(Class)
  end

  it "should define RTFM" do
    Errors::RTFM.should be_a_kind_of(Class)
  end
end
