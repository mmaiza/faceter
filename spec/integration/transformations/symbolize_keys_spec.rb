# encoding: utf-8

describe Faceter::AST::SymbolizeKeys do

  subject { mapper.new.call input }

  let(:input) do
    [
      {
        "id" => 1,
        "user" => {
          "name" => "joe",
          emails: [{ "address" => "joe@doe.com" }]
        },
        "roles" => [{ "name" => "admin" }]
      }
    ]
  end

  let(:output) do
    [
      {
        id: 1,
        user:  {
          name: "joe",
          emails: [{ address: "joe@doe.com" }]
        },
        roles: [{ "name" => "admin" }]
      }
    ]
  end

  let(:mapper) do
    Class.new(Faceter::Mapper) do
      list do
        field "user" do
          symbolize_keys
        end

        symbolize_keys nested: false
      end
    end
  end

  it "works" do
    expect(subject).to eql output
  end

end # Faceter::AST::SymbolizeKeys
