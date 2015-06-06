# encoding: utf-8

describe Faceter::AST::Unwrap do

  subject { mapper.new.call input }

  let(:input) do
    [
      {
        user: {
          id: 1,
          name: "joe"
        },
        contacts: [{ email: { address: "joe@doe.com", type: "job" } }],
        tags: [{ role: "admin" }]
      },
      {
        user: {
          id: 2,
          name: "jane"
        },
        contacts: [{ email: { address: "jane@doe.com", type: "job" } }],
        tags: [{ role: "manager" }]
      }
    ]
  end

  let(:output) do
    [
      {
        id: 1,
        name: "joe",
        contacts: [{ email: { address: "joe@doe.com" }, type: "job" }],
        tags: ["admin"]
      },
      {
        id: 2,
        name: "jane",
        contacts: [{ email: { address: "jane@doe.com" }, type: "job" }],
        tags: ["manager"]
      }
    ]
  end

  let(:mapper) do
    Class.new(Faceter::Mapper) do
      list do
        unwrap :id, :name, from: :user

        field :contacts do
          list do
            unwrap :type, from: :email
          end
        end

        field :tags do
          list do
            unwrap from: :role
          end
        end
      end
    end
  end

  it "works" do
    expect(subject).to eql output
  end

end # Faceter::AST::Unwrap
