require "./expectation"

module HaveFiles::Spec
  module Dsl
    def have_files(expected_dir, base_dir = "/tmp", cleanup = true)
      Expectation.new(expected_dir, base_dir: base_dir, cleanup: cleanup)
    end
  end
end
