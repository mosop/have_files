require "./spec_helper"

it "works" do
  HaveFiles.tmpdir do |expected_dir|
    HaveFiles.tmpdir do |actual_dir|
      actual_dir.should have_files expected_dir
    end
  end
end
