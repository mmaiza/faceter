# encoding: utf-8

require "shared/dsl"

describe Faceter::DSL::Create do

  describe ".new" do

    it_behaves_like "creating immutable node" do
      let(:attributes) { [from: :bar] }
    end

  end # describe .new

  describe "#finalize" do

    it_behaves_like "accepting the node" do
      let(:attributes) { [:foo, from: :baz] }
    end

    it_behaves_like "accepting the node" do
      let(:attributes) { [:foo, from: :foo] }
      let(:block) { proc { |value| value.to_s } }
    end

    it_behaves_like "complaining about the useless node" do
      let(:attributes) { [:foo, from: :foo] }
    end

  end # describe #finalize

  describe "#transproc" do

    it_behaves_like "mapping immutable input" do
      let(:attributes) { [from: :bar] }

      let(:input)  { { bar: :BAR, baz: :BAZ } }
      let(:output) { :BAR                     }
    end

    it_behaves_like "mapping immutable input" do
      let(:attributes) { [:foo, from: :bar] }

      let(:input)  { { bar: :BAR, baz: :BAZ }            }
      let(:output) { { bar: :BAR, baz: :BAZ, foo: :BAR } }
    end

    it_behaves_like "mapping immutable input" do
      let(:attributes) { [:foo, from: [:bar, :baz]] }

      let(:input)  { { bar: :BAR, baz: :BAZ }                    }
      let(:output) { { bar: :BAR, baz: :BAZ, foo: [:BAR, :BAZ] } }
    end

    it_behaves_like "mapping immutable input" do
      let(:attributes) { [:foo, from: :bar]      }
      let(:block)      { proc { |bar| bar.to_s } }

      let(:input)  { { bar: :BAR, baz: :BAZ }             }
      let(:output) { { bar: :BAR, baz: :BAZ, foo: "BAR" } }
    end

    it_behaves_like "mapping immutable input" do
      let(:attributes) { [:foo, from: [:bar, :baz]]       }
      let(:block)      { proc { |args| args.map(&:to_s) } }

      let(:input)  { { bar: :BAR, baz: :BAZ }                   }
      let(:output) { { bar: :BAR, baz: :BAZ, foo: %w(BAR BAZ) } }
    end

  end # describe #transproc

end # describe Faceter::DSL::Create
