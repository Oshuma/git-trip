require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Gitter::Dir do
  before(:each) do
    # This is a test git repository.
    @dir = File.expand_path(File.dirname(__FILE__) + '/../../../sandbox')
  end

  it "should read a repository from a directory" do
    Gitter::Dir.new(@dir).should be_a_kind_of(Gitter::Dir)
  end

  it "should raise Errors::DirNotFound" do
    lambda { Gitter::Dir.new('/not/a/real/dir') }.should raise_error(Errors::DirNotFound)
  end

  it "should raise Errors::InvalidGitRepo" do
    lambda { Gitter::Dir.new(File.dirname(__FILE__)) }.should raise_error(Errors::InvalidGitRepo)
  end

  it "should return an array of commit SHAs"
  it "should return the author of a commit"
end
