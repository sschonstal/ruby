# class item is the base class for the items types in the catalog data
#
# This class will handle all the properties that are common to the data
#
class Item
  def initialize(data)
    @item = data
  end

  def title
    if @item.key?('title')
      if @item['title'].is_a?(String)
        @title = @item['title']
      else
        @title = @item['title']['title']
      end
    end
  rescue
    nil
  end

  def type
    @type = @item['type']
  end

  def price
    @price = @item['price']
  end

  def year
    @year = @item['year']
  end

  def title_year
    @title_year = @item['title']['year']
  rescue
    @title_year = nil
  end

  def year_in_title?
    @item['title'].is_a?(Hash) && @item['title'].key?('year')
  end

  def year_in_chapter?
    false
  end

  def year_in_track?
    false
  end
end
