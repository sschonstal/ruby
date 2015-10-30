#!/usr/bin/ruby
require_relative './lib/parser'

if ARGV.empty?
    fileStream = $stdin
else
    fileStream = File.new(ARGV[0])
end

@parser = Parser.new(fileStream)
puts @parser.data

