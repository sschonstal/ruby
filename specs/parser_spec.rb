require_relative '../lib/parser'

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
end
