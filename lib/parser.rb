require 'json'

# class Parser Initial implementation of Elemental excersize to parce input data
class Parser
  attr_accessor :data

  def initialize(fileStream)
    @data = JSON.parse(fileStream.read)
  end

  def get_top_in_category(top)
    data.group_by { |item| item['type'] }
      .map do |_category, data|
        data.sort_by { |item| -item['price'] }.slice(0, top)
      end
  end

  def get_cds_over(minutes)
    data.select { |item| item['type'] == 'cd' }
      .map { |cd| add_total_run_time(cd) }
      .select { |cd| cd['totalMinutes'] > minutes }
  end

  def add_total_run_time(cd)
    runtime = cd['tracks'].reduce(0) { |a, e| a + e['seconds'] }
    cd['totalMinutes'] = runtime / 60
    return cd # rubocop:disable RedundantReturn
  end
  
  def find_author_intersect(a, b)
    ahash = {}
    data.select { |item| item['type'] == a }
      .each { |item| ahash[item['author']] = item['author'] }

    data.select { |item| item['type'] == b && ahash[item['author']] }
      .map { |item| item['author'] }.uniq
  end

  def find_items_with_deep_year
    data.select { |item| year_in_subitem(item) }
  end

  def year_in_subitem(item)
    year_in_title?(item) ||
      year_in_chapter?(item) ||
      year_in_track?(item)
  end

  def year_in_title?(item)
    if item['title'].is_a?(Hash) && item['title'].key?('year')
      true
    else
      false
    end
  end

  def year_in_chapter?(item)
    item.key?('chapters') &&
      item['chapters']
        .reduce(false) { |a, e| a || (e.is_a?(Hash) && e.key?('year')) }
  end

  def year_in_track?(item)
    item.key?('tracks') &&
      item['tracks']
        .reduce(false) { |a, e| a || (e.is_a?(Hash) && e.key?('year')) }
  end
end
