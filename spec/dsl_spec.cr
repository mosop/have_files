require "./spec_helper"

module HaveFiles::Test
  extend Dsl

  it "responds to have_files" do
    responds_to?(:have_files).should be_true
  end
end
