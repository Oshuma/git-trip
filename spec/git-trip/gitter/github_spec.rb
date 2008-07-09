require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Gitter::GitHub do
  before(:each) do
    @tag = 'Oshuma/git-trip'
    @repo = Gitter::GitHub.new(@tag)
  end

  it "should read a repository from GitHub" do
    @repo.should be_a_kind_of(Gitter::GitHub)
  end

  it "should raise Errors::InvalidFormat" do
    lambda do
      Gitter::GitHub.new(@tag, :format => 'invalid')
    end.should raise_error(Errors::InvalidFormat)
  end

  it "should raise Errors::InvalidGitHubTag" do
    lambda do
      Gitter::GitHub.new('bogus tag')
    end.should raise_error(Errors::InvalidGitHubTag)
  end

  it "should return an array of commit SHAs" do
    @repo.commits.should_not be_empty
  end

  it "should return the author of a commit"
end
