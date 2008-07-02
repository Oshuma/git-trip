require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Gitter do
  before(:each) do
    @url = 'http://github.com/api/v1/json/Oshuma/gitnub/commits/master'
  end

  it "should read a repository from an URL"
  it "should read a repository from a directory"
  it "should return an array of commit SHAs"
  it "should return the author of a commit"
end
