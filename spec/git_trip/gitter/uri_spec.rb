require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Gitter::URI, '(URI)' do
  before(:each) do
    @uri    = 'http://github.com/api/v1/json/Oshuma/git-trip/commits/master'
    @repo   = Gitter::URI.new(@uri)
    @repo.stub!(:commits).and_return([])
  end

  it "should read a repository from a URI" do
    @repo.should be_a_kind_of(Gitter::URI)
  end

  it "should return an array of commit SHAs" do
    @repo.commits
  end

  it "should load data!!!"
  it "should raise Errors::InvalidURI"
  it "should return the author of a commit"
end
