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

  it "should define InvalidMode" do
    Errors::InvalidMode.should be_a_kind_of(Class)
  end

  it "should define InvalidPicture" do
    Errors::InvalidPicture.should be_a_kind_of(Class)
  end

  it "should define InvalidSHA" do
    Errors::InvalidSHA.should be_a_kind_of(Class)
  end

  it "should define InvalidStyle" do
    Errors::InvalidStyle.should be_a_kind_of(Class)
  end

  it "should define NoCommits" do
    Errors::NoCommits.should be_a_kind_of(Class)
  end

  it "should define RTFM" do
    Errors::RTFM.should be_a_kind_of(Class)
  end
end
