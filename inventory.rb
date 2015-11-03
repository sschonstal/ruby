#!/usr/bin/ruby
require_relative './lib/parser'

if ARGV.empty?
  file_stream = $stdin
else
  file_stream = File.new(ARGV[0])
end

@parser = Parser.new(file_stream)

def display_header(data)
  return false unless data[0]
  puts data[0].header
  puts '-' * data[0].header.length
end

def display_items(data, show_details = false)
  display_header(data)
  data.each do |item|
    puts item.to_s
    puts item.details if item.details && show_details
  end
end

def display_by_category(category, show_details = false)
  category.group_by(&:type)
    .map do |name, data|
      puts
      puts 'Category: ' + name
      display_items(data, show_details)
    end
end

def display_authors(authors)
  puts
  puts 'Author name'
  puts '-' * 15
  authors.each { |item| puts item }
end

puts
puts '1. The 5 most expensive items from each category are:'
top = @parser.get_top_in_category(5)
top.each { |category| display_by_category(category) }

puts
puts '2. These cds have a total running time longer than 60 minutes'
display_items(@parser.get_cds_over(60))

puts
puts '3. These authors have also released cds'
authors = @parser.find_author_intersect('cd', 'book')
display_authors(authors)

puts
puts '4. These items have a title, track, or chapter that contains a year'
with_year = @parser.find_items_with_year
display_by_category(with_year, true)

puts
