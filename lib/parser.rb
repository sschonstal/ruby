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
end
