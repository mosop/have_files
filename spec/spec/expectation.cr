require "../spec_helper"

it "Identical" do
  e = HaveFiles::Spec::Expectation.new(__DIR__ + "/../match/identical/expected")
  e.match(__DIR__ + "/../match/identical/actual").should be_true
end

it "Not Identical" do
  e = HaveFiles::Spec::Expectation.new(__DIR__ + "/../match/not_identical/expected")
  e.match(__DIR__ + "/../match/not_identical/actual").should be_false
end

it "Empty" do
  HaveFiles.tmpdir do |expected_dir|
    HaveFiles.tmpdir do |actual_dir|
      e = HaveFiles::Spec::Expectation.new(expected_dir)
      e.match(actual_dir).should be_true
    end
  end
end

it "Empty vs Not Empty" do
  HaveFiles.tmpdir do |expected_dir|
    e = HaveFiles::Spec::Expectation.new(expected_dir)
    e.match(__DIR__ + "/../match/empty_vs_not_empty/actual").should be_false
  end
end

it "Not Empty vs Empty" do
  HaveFiles.tmpdir do |actual_dir|
    e = HaveFiles::Spec::Expectation.new(__DIR__ + "/../match/not_empty_vs_empty/expected")
    e.match(actual_dir).should be_false
  end
end
