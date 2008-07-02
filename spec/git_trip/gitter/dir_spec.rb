require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Gitter::Dir, '(directory)' do
  before(:each) do
    @dir = File.expand_path(File.dirname(__FILE__) + '/../../../sandbox')
  end

  it "should read a repository from a directory" do
    Gitter::Dir.new(@dir).should be_a_kind_of(Gitter::Dir)
  end

  it "should raise Errors::DirNotFound"
  it "should return an array of commit SHAs"
  it "should return the author of a commit"
end
