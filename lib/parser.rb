require 'json'
class Parser

   attr_accessor :data

   def initialize(fileStream)
       @data = JSON.parse(fileStream.read)
   end

   def topInCategory(top)
      data.group_by{|item| item["type"]}
         .map{|category, data| data.sort_by {|item| -item["price"] }
         .slice(0,top)}
   end
end
