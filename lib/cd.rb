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
    @item.key?('tracks') && @item['tracks']
      .reduce(false) { |a, e| a || (e.is_a?(Hash) && e.key?('year')) }
  end

  def total_minutes
    @item['tracks'].reduce(0) { |a, e| a + e['seconds'] } / 60
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
