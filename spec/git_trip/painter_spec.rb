require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe 'common painter', :shared => true do
  it "should raise Errors::RTFM" do
    lambda { Painter.new(5) }.should raise_error(Errors::RTFM)
  end
end

describe Painter, 'with array' do
  it_should_behave_like 'common painter'

  before(:each) do
    @commits = %w{
      ruby is fucking awesome word to your mother
    }.map { |text| Digest::SHA1.hexdigest(text) }
    @painter = Painter.new(@commits)
  end

  it "should instantiate with an array of commits" do
    @painter.should be_instance_of(Painter)
  end

  it "should raise Errors::InvalidSHA" do
    lambda { Painter.new(%w{ not a valid sha }) }.should raise_error(Errors::InvalidSHA)
  end
end

describe Painter, 'with a single commit' do
  it_should_behave_like 'common painter'

  before(:each) do
    @commit  = Digest::SHA1.hexdigest('ruby')
    @painter = Painter.new(@commit)
  end

  it "should instantiate with a single commit" do
    @painter.should be_instance_of(Painter)
  end

  it "should raise Errors::InvalidSHA" do
    lambda { Painter.new('not a valid sha') }.should raise_error(Errors::InvalidSHA)
  end

  it "should return an array of 5 RGB color codes" do
    @painter.colors(@commit).size.should eql(5)
  end
end
