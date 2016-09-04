require "../spec_helper"

it "String should have_files" do
  (__DIR__ + "/../have_files/actual").should have_files(__DIR__ + "/../have_files/expected")
end
