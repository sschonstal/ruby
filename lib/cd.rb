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
end
