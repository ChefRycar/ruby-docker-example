require "rspec"

require "rspec/buildkite/analytics"
RSpec::Buildkite::Analytics.configure(token: "urXKvDfr6Zrj7fXLjSpRHUou")

RSpec.describe "A sample test" do
  it "runs aok" do
    expect(42).to eql(42)
  end
end
