require "./spec_helper"

it "works" do
  (__DIR__ + "/have_files/actual").should have_files __DIR__ + "/have_files/expected"
end

it "works" do
  nil.should have_files(__DIR__ + "/have_files/expected") do |dir|
    File.write dir + "/test.txt", "Hello, World!\n"
  end
end
