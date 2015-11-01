require_relative '../lib/parser'
require 'json'

describe 'parser' do
  before :all do
    file_stream = File.new('test_data.json')
    @parser = Parser.new(file_stream)
  end

  describe 'load' do
    it 'should initialize parser class' do
      expect(@parser).to be_an_instance_of Parser
    end

    it 'should load the test file' do
      expect(@parser.data.length).to equal(19)
    end
  end

  describe 'get_top_in_category' do
    before :each do
      @top = @parser.get_top_in_category(5)
    end

    it 'should return 3 arrays of 5 items' do
      expect(@top[0].length).to equal(5)
      expect(@top[1].length).to equal(5)
      expect(@top[2].length).to equal(5)
    end

    it 'should have most expensive item at head of array' do
      expect(@top[0][0]['price']).to equal(16.99)
      expect(@top[1][0]['price']).to equal(16.99)
      expect(@top[2][0]['price']).to equal(16.99)
    end

    it 'all items should be more than 12.99' do
      @top.each do |category|
        category.each { |item| expect(item['price']).to be > 12.98 }
      end
    end
  end

  describe 'get_cds_over' do
    it 'should only return type CD' do
      @cds = @parser.get_cds_over(0)
      expect(@cds.count { |item| item['type'] != 'cd' }).to equal(0)
      expect(@cds.count { |item| item['type'] == 'cd' }).to be > 0
    end

    it 'should only return 2 cds with totalMinutes > 60' do
      @cds = @parser.get_cds_over(60)
      expect(@cds.count { |item| item['type'] == 'cd' }).to equal(2)
    end

    it 'should only return 4 cds with totalMinutes > 20' do
      @cds = @parser.get_cds_over(20)
      expect(@cds.count { |item| item['type'] == 'cd' }).to equal(2)
    end
  end

  describe 'find_author_intersect' do
    it 'should only return only common autors' do
      authors = @parser.find_author_intersect('cd', 'book')
      expect(authors).to include('Frank Zappa')
      expect(authors).to include('Neil Peart')
      expect(authors).not_to include('Debbie')
      expect(authors).not_to include('Martin Fowler')
    end
  end

  describe 'find_items_with_deep_year' do
    before :all do
      @year_data = @parser.find_items_with_deep_year
    end

    it 'should only return dvds with years in there titles' do
      expect(@year_data.count { |i| i['type'] == 'dvd' }).to equal(2)
      expect(@year_data.count { |i| i['title']['year'] == 1953 }).to equal(1)
      expect(@year_data.count { |i| i['title']['year'] == 2005 }).to equal(1)
    end

    it 'should only return cds with years in atleast one of the tracks' do
      expect(@year_data.count { |i| i['type'] == 'cd' }).to equal(1)
      expect(@year_data.count { |i| i['title'] == 'Rush 2112' }).to equal(1)
    end

    it 'should only return books with years in atleast one of the chapters' do
      expect(@year_data.count { |i| i['type'] == 'book' }).to equal(1)
      expect(@year_data.count { |i| i['title'] == '1984' }).to equal(1)
    end
  end

  describe 'year in sub property oddness' do
    it 'return false if title is a string' do
      item = JSON.parse('{ "title": "string" }')
      expect(@parser.year_in_title?(item)).to be false
    end

    it 'return true if title is an object containing year property' do
      item = JSON.parse('{ "title": { "year": 1999 } }')
      expect(@parser.year_in_title?(item)).to be true
    end

    it 'return false if all chapters are strings' do
      item = JSON.parse('{ "chapters": [ "one", "two", "three" ] }')
      expect(@parser.year_in_chapter?(item)).to be false
    end

    it 'return true if any chapter is an object containing year property' do
      item = JSON.parse('{ "chapters": [ "one", { "year": 1999 }, "three" ] }')
      expect(@parser.year_in_chapter?(item)).to be true
    end

    it 'return false if no tracks contain year' do
      item = JSON.parse('{ "tracks": [
                                       {
                                         "seconds": 180,
                                         "name": "one"
                                       }, {
                                         "seconds": 200,
                                         "name": "two"
                                       }
                                     ]
                         }')
      expect(@parser.year_in_track?(item)).to be false
    end

    it 'return true if any track contains a year' do
      item = JSON.parse('{ "tracks": [
                                       {
                                         "seconds": 180,
                                         "name": "one"
                                       }, {
                                         "seconds": 200,
                                         "name": "two",
                                         "year": 1986
                                       }
                                     ]
                         }')
      expect(@parser.year_in_track?(item)).to be true
    end
  end
end
