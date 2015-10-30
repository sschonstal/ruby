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
         expect(@parser.data.length).to equal(3)
      end
   end
end
