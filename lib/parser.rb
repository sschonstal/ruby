require 'json'
require_relative 'item'
require_relative 'book'
require_relative 'cd'

# class Parser Initial implementation of Elemental excersize to parce input data
class Parser
  attr_accessor :data

  def initialize(fileStream)
    @data = JSON.parse(fileStream.read)
    @items = data.select { |i| i.key?('type') }
             .map do |item|
               begin
                 Object.const_get(item['type'].capitalize).new(item)
               rescue
                 Item.new(item)
               end
             end
  end

  def get_top_in_category(top)
    @items.group_by(&:type)
      .map do |_, data|
        data.sort_by { |i| -i.price }.slice(0, top)
      end
  end

  def get_cds_over(minutes)
    @items.select { |i| i.type == 'cd' }
      .select { |cd| cd.total_minutes > minutes }
  end

  def find_author_intersect(a, b)
    ahash = {}
    @items.select { |i| i.type == a }
      .each { |i| ahash[i.author] = i.author }

    @items.select { |i| i.type == b && ahash[i.author] }
      .map(&:author).uniq
  end

  def find_items_with_year
    @items.select do |item|
      item.year_in_title? ||
        item.year_in_chapter? ||
        item.year_in_track?
    end
  end
end
