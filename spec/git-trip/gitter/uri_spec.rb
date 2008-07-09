require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Gitter::URI do
  before(:each) do
    @uri    = 'http://github.com/api/v1/json/Oshuma/git-trip/commits/master'
    @repo   = Gitter::URI.new(@uri)
  end

  it "should read a repository from a URI" do
    @repo.should be_a_kind_of(Gitter::URI)
  end

  it "should raise Errors::InvalidFormat" do
    lambda do
      Gitter::URI.new(@uri, :format => 'invalid')
    end.should raise_error(Errors::InvalidFormat)
  end

  it "should raise Errors::InvalidURI" do
    lambda { Gitter::URI.new('bogus URI') }.should raise_error(Errors::InvalidURI)
  end

  it "should return an array of commit SHAs" do
    @repo.commits.should_not be_empty
  end

  it "should return the author of a commit"
end
