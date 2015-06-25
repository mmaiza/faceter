# encoding: utf-8

require "shared/dsl"

describe Faceter::DSL::RemovePrefix do

  describe ".new" do

    it_behaves_like "creating immutable node" do
      let(:attributes) { [:foo] }
    end

  end # describe .new

  describe "#transproc" do

    it_behaves_like "mapping immutable input" do
      let(:attributes) { ["foo"] }

      let(:input)  { { foo_bar: { "foo_baz" => :QUX }, "foo.baz" => :BAZ } }
      let(:output) { { bar: { "foo_baz" => :QUX }, "foo.baz" => :BAZ }     }
    end

    it_behaves_like "mapping immutable input" do
      let(:attributes) { ["foo", only: :foo_bar] }

      let(:input)  { { foo_bar: { "foo_baz" => :QUX }, "foo_baz" => :BAZ } }
      let(:output) { { bar: { "foo_baz" => :QUX }, "foo_baz" => :BAZ }     }
    end

    it_behaves_like "mapping immutable input" do
      let(:attributes) { ["foo", except: "foo_baz"] }

      let(:input)  { { foo_bar: { "foo_baz" => :QUX }, "foo_baz" => :BAZ } }
      let(:output) { { bar: { "foo_baz" => :QUX }, "foo_baz" => :BAZ }     }
    end

    it_behaves_like "mapping immutable input" do
      let(:attributes) { ["foo", separator: "."] }

      let(:input)  { { foo_bar: { "foo_baz" => :QUX }, "foo.baz" => :BAZ } }
      let(:output) { { foo_bar: { "foo_baz" => :QUX }, "baz" => :BAZ }     }
    end

    it_behaves_like "mapping immutable input" do
      let(:attributes) { ["foo", nested: true] }

      let(:input)  { { foo_bar: { "foo_baz" => :QUX }, "foo.baz" => :BAZ } }
      let(:output) { { bar: { "baz" => :QUX }, "foo.baz" => :BAZ }         }
    end

    it_behaves_like "mapping immutable input" do
      let(:attributes) { ["foo", except: :foo_bar, nested: true] }

      let(:input)  { { foo_bar: { "foo_baz" => :QUX }, "foo.baz" => :BAZ } }
      let(:output) { { foo_bar: { "baz" => :QUX }, "foo.baz" => :BAZ }     }
    end

    it_behaves_like "mapping immutable input" do
      let(:attributes) { ["foo", only: "foo_baz", nested: true] }

      let(:input)  { { foo_bar: { "foo_baz" => :QUX }, "foo.baz" => :BAZ } }
      let(:output) { { foo_bar: { "baz" => :QUX }, "foo.baz" => :BAZ }     }
    end

  end # describe #transproc

end # describe Faceter::DSL::RemovePrefix
