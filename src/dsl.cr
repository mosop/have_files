require "./have_files"

module HaveFiles
  module Dsl
    def have_files(expected_dir, base_dir = "/tmp", cleanup = true)
      HaveFiles::Expectation.new(expected_dir, base_dir: base_dir, cleanup: cleanup)
    end

    def have_files(expected_dir, base_dir = "/tmp", cleanup = true, &block : String ->)
      HaveFiles::Expectation.new(expected_dir, base_dir: base_dir, cleanup: cleanup, &block)
    end
  end
end
