require_relative '../lib/cd'

describe 'cd' do
  describe 'author' do
    it 'should extract my author' do
      data = { 'title' => 'my title', 'author' => 'sam schonstal' }
      cd = Cd.new(data)
      expect(cd.author).to match('sam schonstal')
    end
  end
  it 'return false if no tracks contain year' do
    data = { 'tracks' => [{ 'seconds' => 180,
                            'name' => 'one'
                          }, {
                            'seconds' => 200,
                            'name' => 'two'
                          }] }
    cd = Cd.new(data)
    expect(cd.year_in_track?).to be false
  end

  it 'return true if any track contains a year' do
    data = { 'tracks' => [{ 'seconds' => 180,
                            'name' => 'one'
                          }, {
                            'seconds' => 200,
                            'name' => 'two 1234'
                          }] }
    cd = Cd.new(data)
    expect(cd.year_in_track?).to be true
  end

  describe 'to_s' do
    it 'should format string for display' do
      data = { 'type' => 'cd',
               'title' => '1234567890123456789012345',
               'year' => 1999,
               'author' => 'asdfghjklqwertyuiop',
               'tracks' => [{ 'seconds' => 4000 }],
               'price' => 253.99 }
      item = Cd.new(data)
      expect(item.to_s).to match('cd   123456789012345678901234'\
                                ' asdfghjklqwertyuiop 1999 66   253.99')
    end
  end
end
