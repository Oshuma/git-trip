require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Gitter::Base do
  before(:each) do
    @commits = %w{
      ruby is fucking awesome word to your mother
    }.map { |text| Digest::SHA1.hexdigest(text) }
    @repo = mock(Gitter::Base)
    @repo.stub!(:commits).and_return(@commits)
  end

  it "should return an array of commit SHAs" do
    @repo.commits.should be_instance_of(Array)
  end
end
