require_relative 'item'
# class cd
#
class Cd < Item
  def initialize(item)
    super(item)
  end

  def author
    @author = @item['author']
  end

  def year_in_track?
    tracks.reduce(false) { |a, e| a || year?(e['name']) }
  end

  def total_minutes
    tracks.reduce(0) { |a, e| a + (e['seconds'] || 0) } / 60
  end

  def tracks
    @tracks = @item['tracks'] || {}
  end

  def to_s
    format('%-5.4s%-25.24s%-20.19s%-4d %-4d %.2f',
           type, title, author, year, total_minutes, price)
  end

  def header
    format('%-5.4s%-25.24s%-20.19s%-4s %-4s %s',
           'Type', 'Title', 'Author', 'Year', 'Time', 'Price')
  end

  def details
    @item['tracks'].reduce('') do |str, track|
      str << format("        |_ %s\n", track['name'])
    end
  end
end
