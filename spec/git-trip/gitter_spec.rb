require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Gitter, '(module)' do
  it "should include Gitter::Base" do
    Gitter::Base.should be_a_kind_of(Class)
  end

  it "should include Gitter::Dir" do
    Gitter::Dir.should be_a_kind_of(Class)
  end

  it "should include Gitter::GitHub" do
    Gitter::GitHub.should be_a_kind_of(Class)
  end

  it "should include Gitter::URI" do
    Gitter::URI.should be_a_kind_of(Class)
  end
end
