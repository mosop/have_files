module HaveFiles::Spec
  module Dsl
    def have_files(expected_dir, base_dir = "/tmp", cleanup = true)
      Expectation.new(expected_dir, base_dir: base_dir, cleanup: cleanup)
    end

    def have_files(expected_dir, base_dir = "/tmp", cleanup = true, &block : String ->)
      Expectation.new(expected_dir, base_dir: base_dir, cleanup: cleanup, &block)
    end
  end
end
