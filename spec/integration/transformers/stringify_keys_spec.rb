# encoding: utf-8

describe Faceter::Builder, "#stringify_keys" do

  subject { mapper.new.call input }

  let(:input) do
    [
      {
        id: 1,
        user:  {
          name: "joe",
          "emails" => [{ address: "joe@doe.com" }]
        },
        roles: [{ name: "admin" }]
      },
      {
        id: 2,
        user:  {
          name: "jane",
          "emails" => [{ address: "jane@doe.com" }]
        },
        roles: [{ name: "admin" }]
      }
    ]
  end

  let(:output) do
    [
      {
        "id" => 1,
        "user" => {
          "name" => "joe",
          "emails" => [{ "address" => "joe@doe.com" }]
        },
        "roles" => [{ name: "admin" }]
      },
      {
        "id" => 2,
        "user" => {
          "name" => "jane",
          "emails" => [{ "address" => "jane@doe.com" }]
        },
        "roles" => [{ name: "admin" }]
      }
    ]
  end

  let(:mapper) do
    Class.new(Faceter::Mapper) do
      list do
        field :user do
          stringify_keys
        end

        stringify_keys nested: false
      end
    end
  end

  it "works" do
    expect(subject).to eql output
  end

end # describe Faceter::Builder#stringify_keys
