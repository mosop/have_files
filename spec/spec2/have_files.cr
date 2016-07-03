require "../spec_helper"

Spec2.describe "have_files" do
  it "string should have files" do
    expect(__DIR__ + "/../have_files/actual").to have_files(__DIR__ + "/../have_files/expected")
  end

  it "nil should have files" do
    expect(nil).to have_files(__DIR__ + "/../have_files/expected") do |dir|
      File.write dir + "/test.txt", "Hello, World!\n"
    end
  end
end
