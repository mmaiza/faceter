# encoding: utf-8

shared_context "node" do

  let(:node) do
    if defined? block
      described_class.new(*attributes, &block)
    else
      described_class.new(*attributes)
    end
  end

end # shared context

# The examples for testing a Node#new
shared_examples "creating immutable node" do

  subject { described_class.new(*attributes) }

  it { is_expected.to be_kind_of Faceter::Node }
  it { is_expected.to be_frozen }

end # shared examples

# The examples for testing a Branch#new
shared_examples "creating immutable branch" do

  subject { described_class.new(*attributes) }

  it { is_expected.to be_kind_of Faceter::Branch }
  it { is_expected.to be_frozen }

end # shared examples

# The examples for testing a Node#finalize
shared_examples "accepting the node" do

  include_context "node"

  subject { node.finalize }

  it { is_expected.to eql node }

end # shared examples

shared_examples "complaining about the useless node" do

  include_context "node"

  subject { node.finalize }

  it "fails" do
    expect { subject }.to raise_error do |error|
      expect(error).to be_kind_of Faceter::Error
      expect(error.message).to include(node.to_s)
    end
  end

end # shared examples

# The examples for testing a Node#transproc
shared_examples "transforming immutable data" do

  include_context "node"

  subject { node.transproc.call(input.freeze) }

  it do
    is_expected.to eql(output), <<-REPORT.gsub(/.+\|/, "")
      |
      |#{node}
      |
      |Input: #{input}
      |
      |Output:
      |  expected: #{output}
      |       got: #{subject}
    REPORT
  end

end # shared examples
