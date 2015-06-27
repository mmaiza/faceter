# encoding: utf-8

describe Faceter::DSL do

  describe ".setup" do

    it "evaluates the block" do
      expect(described_class.setup { :foo }).to eql :foo
    end

    it "uses the DSL scope" do
      expect(described_class.setup { self }).to eql described_class
    end

  end # describe .setup

  describe ".commands" do

    subject { described_class.commands }
    it { is_expected.to be_kind_of Hash }

  end # describe .commands

  describe ".command" do

    before { Faceter::Foo = Class.new(Faceter::Node) }
    after  { Faceter.send :remove_const, :Foo        }

    subject { described_class.command "foo", Faceter::Foo }

    it "registers a command" do
      expect { subject }
        .to change { described_class.commands[:foo] }
        .from(nil)
        .to Faceter::Foo
    end

  end # describe .command

  describe ".command?" do

    before do
      allow(described_class).to receive(:commands).and_return(foo: :FOO)
    end

    context "registered name" do

      subject { described_class.command? :foo }
      it { is_expected.to eql true }

    end # context

    context "unregistered name" do

      subject { described_class.command? :bar }
      it { is_expected.to eql false }

    end # context

  end # describe .command?

end # describe Faceter::DSL
