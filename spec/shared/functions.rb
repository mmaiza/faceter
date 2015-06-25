# encoding: utf-8

# The examples for testing transproc functions
shared_examples "transforming immutable data" do

  let(:fn) { described_class[*arguments] }

  subject { fn[input.freeze] }

  it do
    is_expected.to eql(output), <<-REPORT.gsub(/.+\|/, "")
      |
      |#{described_class}#{arguments}
      |
      |Input: #{input}
      |
      |Output:
      |  expected: #{output}
      |       got: #{subject}
    REPORT
  end

end # shared examples
