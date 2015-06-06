# encoding: utf-8

describe Faceter::AST::Create do

  subject { mapper.new.call input }

  let(:input) do
    [{ foo: 1, bar: 3, baz: %w(5 7) }]
  end

  let(:output) do
    [{ foo: 1, bar: 3, qux: 4, baz: "5-7" }]
  end

  let(:mapper) do
    Class.new(Faceter::Mapper) do
      list do
        create :qux, from: [:foo, :bar] do |foo, bar|
          foo + bar
        end

        field :baz do
          create do |data|
            data.join("-")
          end
        end
      end
    end
  end

  it "works" do
    expect(subject).to eql output
  end

end # Faceter::AST::Create
