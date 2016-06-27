require "./spec_helper"

it "works" do
  (__DIR__ + "/empty_files/actual").should have_files __DIR__ + "/empty_files/expected"
end
