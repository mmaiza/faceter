# encoding: utf-8

require "shared/dsl"

describe Faceter::DSL::Group do

  describe ".new" do

    it_behaves_like "creating immutable node" do
      let(:attributes) { [:foo, to: :bar] }
    end

  end # describe .new

  describe "#transproc" do

    it_behaves_like "mapping immutable input" do
      let(:attributes) { [:foo, :bar, to: :baz] }

      let(:input) do
        [
          { foo: :FOO, bar: :FOO, qux: :QUX },
          { foo: :BAR, bar: :BAR, qux: :QUX }
        ]
      end

      let(:output) do
        [
          {
            qux: :QUX,
            baz: [{ foo: :FOO, bar: :FOO }, { foo: :BAR, bar: :BAR }]
          }
        ]
      end
    end

    it_behaves_like "mapping immutable input" do
      let(:attributes) { [[:foo, :bar], to: :baz] }

      let(:input) do
        [
          { foo: :FOO, bar: :FOO, baz: :BAZ, qux: :QUX },
          { foo: :BAR, bar: :BAR, baz: :BAZ, qux: :QUX }
        ]
      end

      let(:output) do
        [
          {
            qux: :QUX,
            baz: [{ foo: :FOO, bar: :FOO }, { foo: :BAR, bar: :BAR }]
          }
        ]
      end
    end

    it_behaves_like "mapping immutable input" do
      let(:attributes) { [:foo, :bar, to: :baz] }

      let(:input) do
        [
          { foo: :FOO, bar: :FOO, baz: { bar: :BAZ }, qux: :QUX },
          { foo: :BAR, bar: :BAR, baz: { bar: :BAZ }, qux: :QUX }
        ]
      end

      let(:output) do
        [
          {
            qux: :QUX,
            baz: [{ foo: :FOO, bar: :FOO }, { foo: :BAR, bar: :BAR }]
          }
        ]
      end
    end

    it_behaves_like "mapping immutable input" do
      let(:attributes) { [:foo, :bar, to: :baz] }

      let(:input) do
        [
          { foo: :FOO, bar: :FOO, baz: [{ baz: :BAZ  }], qux: :QUX },
          { foo: :BAR, bar: :BAR, baz: [{ baz: :BAZZ }], qux: :QUX }
        ]
      end

      let(:output) do
        [
          {
            qux: :QUX,
            baz: [
              { foo: :FOO, bar: :FOO, baz: :BAZ },
              { foo: :BAR, bar: :BAR, baz: :BAZZ }
            ]
          }
        ]
      end
    end

    it_behaves_like "mapping immutable input" do
      let(:attributes) { [:foo, to: :bar] }

      let(:input) do
        [
          { foo: :FOO, bar: [{ baz: :FOO }, { baz: :BAR }], qux: :QUX },
          { foo: :BAR, bar: [{ baz: :BAZ }, { baz: :QUX }], qux: :QUX }
        ]
      end

      let(:output) do
        [
          {
            qux: :QUX,
            bar: [
              { baz: :FOO, foo: :FOO },
              { baz: :BAR, foo: :FOO },
              { baz: :BAZ, foo: :BAR },
              { baz: :QUX, foo: :BAR }
            ]
          }
        ]
      end
    end

    # it_behaves_like "mapping immutable input" do
    #   let(:attributes) { [:foo, :baz, to: :foo] }

    #   let(:input) do
    #     [
    #       { foo: :FOO, baz: :FOO, qux: :QUX },
    #       { foo: :BAR, baz: :BAR, qux: :QUX }
    #     ]
    #   end

    #   let(:output) do
    #     [
    #       {
    #         qux: :QUX,
    #         foo: [{ foo: :FOO, baz: :FOO }, { foo: :BAR, baz: :BAR }]
    #       }
    #     ]
    #   end
    # end

    # it_behaves_like "mapping immutable input" do
    #   let(:attributes) { [:foo, to: :foo] }

    #   let(:input) do
    #     [
    #       { foo: [{ bar: :FOO }, { baz: :FOO  }], qux: :QUX },
    #       { foo: [{ bar: :BAR }, { baz: :BAR }],  qux: :QUX }
    #     ]
    #   end

    #   let(:output) do
    #     [
    #       {
    #         qux: :QUX,
    #         foo: [
    #           { foo: [{ bar: :FOO }, { baz: :FOO  }] },
    #           { foo: [{ bar: :BAR }, { baz: :BAR }] }
    #         ]
    #       }
    #     ]
    #   end
    # end

  end # describe #transproc

end # describe Faceter::DSL::Group
