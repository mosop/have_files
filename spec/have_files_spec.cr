require "./spec_helper"

it "may work" do
  (__DIR__ + "/actual").should have_files __DIR__ + "/expected"
end

it "may work" do
  nil.should have_files(__DIR__ + "/expected") do |dir|
    File.write dir + "/test.txt", "Hello, World!\n"
  end
end
