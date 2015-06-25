# encoding: utf-8

require "shared/dsl"

describe Faceter::DSL::Ungroup do

  describe ".new" do

    it_behaves_like "creating immutable node" do
      let(:attributes) { [from: :baz] }
    end

  end # describe .new

  describe "#transproc" do

    # it_behaves_like "mapping immutable input" do
    #   let(:attributes) { [from: :baz] }

    #   let(:input) do
    #     [
    #       {
    #         baz: [{ foo: :FOO, bar: :FOO }, { foo: :BAR, bar: :BAR }],
    #         qux: :QUX
    #       }
    #     ]
    #   end

    #   let(:output) do
    #     [
    #       { foo: :FOO, bar: :FOO, qux: :QUX },
    #       { foo: :BAR, bar: :BAR, qux: :QUX }
    #     ]
    #   end
    # end

    it_behaves_like "mapping immutable input" do
      let(:attributes) { [:foo, :bar, from: :baz] }

      let(:input) do
        [
          {
            baz: [{ foo: :FOO, bar: :FOO }, { foo: :BAR, bar: :BAR }],
            qux: :QUX
          }
        ]
      end

      let(:output) do
        [
          { foo: :FOO, bar: :FOO, qux: :QUX },
          { foo: :BAR, bar: :BAR, qux: :QUX }
        ]
      end
    end

    # it_behaves_like "mapping immutable input" do
    #   let(:attributes) { [:foo, :bar, from: :baz] }

    #   let(:input) do
    #     [
    #       {
    #         baz: [{ foo: :FOO, bar: :FOO }, { foo: :BAR, bar: :BAR }],
    #         foo: :QUX,
    #         qux: :QUX
    #       }
    #     ]
    #   end

    #   let(:output) do
    #     [
    #       { foo: :FOO, bar: :FOO, qux: :QUX },
    #       { foo: :BAR, bar: :BAR, qux: :QUX }
    #     ]
    #   end
    # end

    it_behaves_like "mapping immutable input" do
      let(:attributes) { [[:foo, :bar], from: :foo] }

      let(:input) do
        [
          {
            foo: [{ foo: :FOO, bar: :FOO }, { foo: :BAR, bar: :BAR }],
            qux: :QUX
          }
        ]
      end

      let(:output) do
        [
          { foo: :FOO, bar: :FOO, qux: :QUX },
          { foo: :BAR, bar: :BAR, qux: :QUX }
        ]
      end
    end

  end # describe #transproc

end # describe Faceter::DSL::Ungroup
