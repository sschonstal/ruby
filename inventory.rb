#!/usr/bin/ruby
require_relative './lib/parser'

if ARGV.empty?
  file_stream = $stdin
else
  file_stream = File.new(ARGV[0])
end

@parser = Parser.new(file_stream)
puts @parser.data
