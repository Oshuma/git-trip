require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Gitter do
  before(:each) do
    @dir = File.expand_path(File.dirname(__FILE__) + '/../../')
    @url = 'http://github.com/api/v1/json/Oshuma/gitnub/commits/master'
  end

  it "should read a repository from a directory" do
    Gitter.new(:dir => @dir).should be_a_kind_of(Gitter)
  end

  it "should read a repository from an URL" do
    Gitter.new(:url => @url).should be_a_kind_of(Gitter)
  end

  it "should return an array of commit SHAs"
  it "should return the author of a commit"
end
