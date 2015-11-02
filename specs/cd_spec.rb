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
                            'year' => 1986,
                            'name' => 'two'
                          }] }
    cd = Cd.new(data)
    expect(cd.year_in_track?).to be true
  end
end
