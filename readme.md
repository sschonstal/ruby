# Readme
## Description
Coding exercise for Elemental Technologies
by Sam Schonstal - November 3, 2015

#Usage

main entry point for application is *inventory*

The program expects a json file containing inventory data as described in the requirements.
input data and be pipped or redirected via stdin like this:

   $ cat test_data.json | ./inventory.rb
or
   $ ./inventory.rb < test_data.json

or passed as an input parameter like this:

   $ ./inventory.rb test_data.json

#Testing

rspec unit tests are included. Some or the tests depend on the test_data.json file
to run these test you must be in the root directory of the project and run

  $ rspec specs

#Assumptions

Requirement # 4 asked "Which items have a title, track, or chapter that contains a year."
Identifying a year in a string is tricky.  I made the assumption that any number 
surrounded by white space that is 4 or less digits and does not start with a 0 is a year.

The test is abstracted in the base item class and is implemented via regex and can 
be modified as additional criteria are required.
