require_relative '../lib/parser'
 
describe "parser" do
   before :all do
      #ios = IO.new STDOUT.fileno
      fileStream = File.new("test_data.json")
      @parser = Parser.new(fileStream) 
   end

   describe "load" do
      it "should initialize parser class" do
         expect(@parser).to be_an_instance_of Parser
      end

      it "should load the test file" do
         expect(@parser.data.length).to equal(19)
      end
   end

   describe "topInCategory" do
      before :each do
         @top = @parser.topInCategory(5)
      end

      it "should return 3 arrays of 5 items" do
         expect(@top[0].length).to equal(5)
         expect(@top[1].length).to equal(5)
         expect(@top[2].length).to equal(5)
      end

      it "should have most expensive item at head of array" do
         expect(@top[0][0]["price"]).to equal(16.99)
         expect(@top[1][0]["price"]).to equal(16.99)
         expect(@top[2][0]["price"]).to equal(16.99)
      end

      it "all items should be more than 12.99" do
         @top.each { |category| category.each{ |item| expect(item["price"]).to be > 12.98}}
      end
   end
end
