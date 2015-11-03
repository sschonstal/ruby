require_relative '../lib/book'

describe 'book' do
  describe 'author' do
    it 'should extract my author' do
      data = { 'title' => 'my title', 'author' => 'sam schonstal' }
      book = Book.new(data)
      expect(book.author).to match('sam schonstal')
    end
  end
  describe 'year_in_chapter' do
    it 'return false if all chapters are strings' do
      data = { 'chapters' => %w(one two three) }
      book = Book.new(data)
      expect(book.year_in_chapter?).to be false
    end

    it 'return true if any chapter is an object containing year property' do
      data = { 'chapters' => ['one', 'year 1999', 'three'] }
      book = Book.new(data)
      expect(book.year_in_chapter?).to be true
    end
  end
end
