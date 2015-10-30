require 'json'
class Parser

   attr_accessor :data

   def initialize(fileStream)
       @data =  JSON.parse(fileStream.read)
   end
end
