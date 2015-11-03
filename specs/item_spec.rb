require_relative '../lib/item'

describe 'item' do
  describe 'title' do
    it 'should extract my title' do
      data = { 'title' => 'my title' }
      item = Item.new(data)
      expect(item.title).to match('my title')
    end
    it 'should return nill if no title' do
      data = { 'something' => 'my title' }
      item = Item.new(data)
      expect(item.title).to equal(nil)
    end
    it 'should return nill if title is not string or hash' do
      data = { 'title' => 23 }
      item = Item.new(data)
      expect(item.title).to equal(nil)
    end
  end
  describe 'type' do
    it 'should return book for type' do
      data = { 'type' => 'book' }
      item = Item.new(data)
      expect(item.type).to match('book')
    end
    it 'should return nil if no type' do
      data = { 'something' => 'my title' }
      item = Item.new(data)
      expect(item.type).to equal(nil)
    end
  end
  describe 'price' do
    it 'should return 5.99 for price' do
      data = { 'price' => 5.99 }
      item = Item.new(data)
      expect(item.price).to equal(5.99)
    end
  end
  describe 'year' do
    it 'should return 1963 for year' do
      data = { 'year' => 1963 }
      item = Item.new(data)
      expect(item.year).to equal(1963)
    end
  end
  describe 'to_s' do
    it 'should format string for display' do
      data = { 'type' => 'cd',
               'title' => '123456789012345678901234567890',
               'year' => 1999,
               'price' => 253.99 }
      item = Item.new(data)
      expect(item.to_s).to match('cd   123456789012345678901234'\
                                 ' 1999 253.99')
    end
  end
  describe 'year in title' do
    it 'return false if title is a string' do
      item = { 'title' => 'string' }
      item = Item.new(item)
      expect(item.year_in_title?).to be false
    end
    it 'return true if title contains a year' do
      item = { 'title' => 'this is a year 1999' }
      item = Item.new(item)
      expect(item.year_in_title?).to be true
    end
  end
  describe 'year?' do
    it 'should return true if string contains 1 to 4 digit number' do
      expect(Item.new({}).year?('1995')).to be true
      expect(Item.new({}).year?('99')).to be true
      expect(Item.new({}).year?('summer of 69')).to be true
      expect(Item.new({}).year?('rome 368 a bad year')).to be true
    end
    it 'should return false if string dosnt contain year' do
      expect(Item.new({}).year?('i995')).to be false
      expect(Item.new({}).year?('99p')).to be false
      expect(Item.new({}).year?('summer of')).to be false
    end
  end
end
