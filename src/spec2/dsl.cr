require "./matcher"

module HaveFiles::Spec2
  module Dsl
    def have_files(expected_dir : String, base_dir : String = "/tmp", cleanup : Bool = true)
      HaveFiles::Spec2::Matcher.new(expected_dir, base_dir, cleanup)
    end
  end
end

module Spec2::Matchers
  include HaveFiles::Spec2::Dsl
end
