#!/usr/bin/ruby
require_relative './lib/parser'

if ARGV.empty?
  file_stream = $stdin
else
  file_stream = File.new(ARGV[0])
end

@parser = Parser.new(file_stream)

def display_item(item)
  puts format('%-20.19s $%.2f',
              item['title']['title'] || item['title'],
              item['price'])
end

def display_items(data)
  puts format('%-20s %6s', 'Title', 'Price')
  puts '-' * 30
  data.each { |item| display_item(item) }
end

def display_by_category(name, data)
  puts
  puts 'Category: ' + name
  display_items(data)
end

def display_top(category)
  category.group_by { |item| item['type'] }
    .map { |name, data| display_by_category(name, data) }
end

def display_cd(item)
  puts format('%-20.19s %-15.14s %-5s %8d',
              item['title'],
              item['author'],
              item['year'],
              item['totalMinutes'])
end

def display_cds(cds)
  puts
  puts format('%-20.19s %-15.14s %-5s %8s', 'Title', 'Author', 'Year', 'Length')
  puts '-' * 55
  cds.each { |item| display_cd(item) }
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
top.each { |category| display_top(category) }

puts
puts '2. These cds have a total running time longer than 60 minutes'
long = @parser.get_cds_over(60)
display_cds(long)

puts
puts '3. These authors have also released cds'
authors = @parser.find_author_intersect('cd', 'book')
display_authors(authors)

puts
puts '4. These items have a title, track, or chapter that contains a year'
with_year = @parser.find_items_with_deep_year
display_items(with_year)

puts
