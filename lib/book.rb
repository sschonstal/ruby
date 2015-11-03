require_relative 'item'
# class book
#
class Book < Item
  def initialize(item)
    super(item)
  end

  def author
    @author = @item['author']
  end

  def year_in_chapter?
    @item.key?('chapters') && @item['chapters']
      .reduce(false) { |a, e| a || year?(e) }
  end

  def details
    @item['chapters'].reduce('') do |str, chapter|
      str << format("        |_ %s\n", chapter)
    end
  end
end
