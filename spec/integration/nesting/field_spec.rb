# encoding: utf-8

describe Faceter::AST::Field do

  subject { mapper.new.call input }

  let(:input) do
    [{ foo: 1, bar: { foo: :BAZ } }]
  end

  let(:output) do
    [{ qux: 1, bar: { baz: :BAZ } }]
  end

  let(:mapper) do
    Class.new(Faceter::Mapper) do
      list do
        rename :foo, to: :qux

        field :bar do
          rename :foo, to: :baz
        end
      end
    end
  end

  it "works" do
    expect(subject).to eql output
  end

end # describe Faceter::AST::Field
