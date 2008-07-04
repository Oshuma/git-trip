require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Gitter::Dir do
  before(:each) do
    # This is a test git repository.
    @dir = File.expand_path(File.dirname(__FILE__) + '/../../../sandbox')
    @repo = Gitter::Dir.new(@dir)
  end

  it "should read a repository from a directory" do
    @repo.should be_a_kind_of(Gitter::Dir)
  end

  it "should raise Errors::DirNotFound" do
    lambda { Gitter::Dir.new('/not/a/real/dir') }.should raise_error(Errors::DirNotFound)
  end

  it "should raise Grit::InvalidGitRepositoryError" do
    lambda do
      Gitter::Dir.new(File.dirname(__FILE__))
    end.should raise_error(Grit::InvalidGitRepositoryError)
  end

  it "should return an array of commit SHAs" do
    @repo = Gitter::Dir.new(@dir)
    @repo.commits.should_not be_empty
  end

  it "should iterate the commits" do
    @repo.each_commit do |c|
      c.should be_instance_of(String)
      c.size.should eql(40) # size of a SHA1
    end
  end

  it "should return the author of a commit"
end
