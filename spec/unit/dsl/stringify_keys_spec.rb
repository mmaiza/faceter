# encoding: utf-8

require "shared/dsl"

describe Faceter::DSL::StringifyKeys do

  describe ".new" do

    it_behaves_like "creating immutable node" do
      let(:attributes) { [] }
    end

  end # describe .new

  describe "#transproc" do

    it_behaves_like "mapping immutable input" do
      let(:attributes) { [] }

      let(:input)  { { foo: [{ bar: :BAZ }] }         }
      let(:output) { { "foo" => [{ "bar" => :BAZ }] } }
    end

    it_behaves_like "mapping immutable input" do
      let(:attributes) { [only: :bar] }

      let(:input)  { { foo: [{ bar: :BAZ }] }         }
      let(:output) { { foo: [{ "bar" => :BAZ }] } }
    end

    it_behaves_like "mapping immutable input" do
      let(:attributes) { [except: :foo] }

      let(:input)  { { foo: [{ bar: :BAZ }] }         }
      let(:output) { { foo: [{ "bar" => :BAZ }] } }
    end

    it_behaves_like "mapping immutable input" do
      let(:attributes) { [nested: false] }

      let(:input)  { { foo: [{ bar: :BAZ }] }     }
      let(:output) { { "foo" => [{ bar: :BAZ }] } }
    end

    it_behaves_like "mapping immutable input" do
      let(:attributes) { [except: :foo, nested: false] }

      let(:input)  { { foo: [{ bar: :BAZ }], qux: :QUX }     }
      let(:output) { { foo: [{ bar: :BAZ }], "qux" => :QUX } }
    end

    it_behaves_like "mapping immutable input" do
      let(:attributes) { [only: :foo, nested: false] }

      let(:input)  { { foo: [{ bar: :BAZ }], qux: :QUX }     }
      let(:output) { { "foo" => [{ bar: :BAZ }], qux: :QUX } }
    end

  end # describe #transproc

end # describe Faceter::DSL::StringifyKeys
