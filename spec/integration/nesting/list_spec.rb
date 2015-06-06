# encoding: utf-8

describe Faceter::AST::List do

  subject { mapper.new.call input }

  let(:input) do
    [[{ foo: 1 }, { foo: 2 }], [{ foo: 3 }, { foo: 4 }]]
  end

  let(:output) do
    [[{ qux: 1 }, { qux: 2 }], [{ qux: 3 }, { qux: 4 }]]
  end

  let(:mapper) do
    Class.new(Faceter::Mapper) do
      list do
        list do
          rename :foo, to: :qux
        end
      end
    end
  end

  it "works" do
    expect(subject).to eql output
  end

end # describe Faceter::AST::List
