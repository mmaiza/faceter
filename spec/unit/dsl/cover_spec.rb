# encoding: utf-8

require "shared/dsl"

describe Faceter::DSL::Cover do

  describe ".new" do

    it_behaves_like "creating immutable node" do
      let(:attributes) { [to: :foo] }
    end

  end # describe .new

  describe "#transproc" do

    it_behaves_like "transforming immutable data" do
      let(:attributes) { [to: :foo] }

      let(:input)  { :FOO          }
      let(:output) { { foo: :FOO } }
    end

    it_behaves_like "transforming immutable data" do
      let(:attributes) { [to: :foo] }

      let(:input)  { nil          }
      let(:output) { { foo: nil } }
    end

  end # describe #transproc

end # describe Faceter::DSL::Cover
