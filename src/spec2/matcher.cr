require "../common"
require "spec2"
require "../spec/expectation"

module HaveFiles::Spec2
  class Matcher
    include ::Spec2::Matcher

    @spec_expectation : ::HaveFiles::Spec::Expectation
    @expected_dir : String
    @actual : String?

    def initialize(@expected_dir : String, base_dir : String = "/tmp", cleanup : Bool = true)
      @spec_expectation = ::HaveFiles::Spec::Expectation.new(@expected_dir, base_dir, cleanup)
    end

    def initialize(@expected_dir : String, base_dir : String = "/tmp", cleanup : Bool = true, &block : (String ->))
      @spec_expectation = ::HaveFiles::Spec::Expectation.new(@expected_dir, base_dir, cleanup, &block)
    end

    def match(actual)
      @actual = actual
      @spec_expectation.match(actual)
    end

    def failure_message
      @spec_expectation.failure_message(@actual)
    end

    def failure_message_when_negated
      @spec_expectation.negative_failure_message(@actual)
    end

    def description
      "should have files what #{@expected_dir} has"
    end
  end
end
