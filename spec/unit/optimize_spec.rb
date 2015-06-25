# encoding: utf-8

describe Faceter::Optimizer do

  subject(:optimizer) { described_class.new tree }

  let(:tree) { double }

  describe ".[]" do

    subject { described_class[tree] }

    it "creates and calls the optimizer" do
      expect(described_class).to receive_message_chain(:new, :call)
      subject
    end

  end # describe .[]

  describe ".new" do

    it { is_expected.to be_frozen }

  end # describe .new

  describe "#tree" do

    subject { optimizer.tree }
    it { is_expected.to eql tree }

  end # describe #tree

  # describe "#call" do

  #   let(:input) do
  #     Faceter::Builder.new do
  #       list do
  #         field :foo do
  #           rename :foo, to: :bar
  #         end
  #       end

  #       list do
  #         field :foo do
  #           rename :baz, to: :qux
  #         end
  #       end
  #     end
  #   end

  #   let(:output) do
  #     Faceter::Builder.new do
  #       list do
  #         field :foo do
  #           rename :foo, to: :bar
  #           rename :baz, to: :qux
  #         end
  #       end
  #     end
  #   end

  #   subject { described_class.new(input.tree).call }
  #   it { is_expected.to eql output.tree }

  # end # describe #call

end # describe Faceter::Optimize
