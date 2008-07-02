require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Hash, 'core extensions' do
  before(:each) do
    @hash = {
      'key1' => 'val1',
      'key2' => [1, 2, 3],
      'key3' => {:a => 1, :b => 2}
    }
  end

  it "should symbolize keys" do
    symbol_keys = @hash.symbolize_keys
    symbol_keys.each_key do |key|
      key.should be_a_kind_of(Symbol)
    end
  end
  
  it "should symbolize keys destructively" do
    @hash.symbolize_keys!
    @hash.each_key do |key|
      key.should be_a_kind_of(Symbol)
    end
  end
end
