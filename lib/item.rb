# class item is the base class for the items types in the catalog data
#
# This class will handle all the properties that are common to the data
#
class Item
  def initialize(data)
    @price = 0
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
    year?(@item['title'])
  end

  def year_in_chapter?
    false
  end

  def year_in_track?
    false
  end

  def to_s
    format('%-5.4s%-25.24s%-5.4d%.2f',
           type, title, year, price)
  end

  def header
    format('%-5.4s%-25.24s%-5s%s',
           'Type', 'Title', 'Year', 'Price')
  end

  def details
    nil
  end

  def year?(str)
    gotit = str =~ /(^|\s)[1-9][0-9]{0,3}($|\s)/
    gotit.nil? ? false : true
  end
end
