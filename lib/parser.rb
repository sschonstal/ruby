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

   def getCdsOver(minutes)
      data.select{|item| item["type"] == "cd"}
         .map{|cd| addTotalRunTime(cd)}
         .select{|cd| cd["totalMinutes"] > minutes}
   end

   def addTotalRunTime(cd)
      runtime = cd["tracks"].reduce(0){ |total, track| total + track["seconds"]}
      cd["totalMinutes"] = runtime/60
      return cd
   end
end

