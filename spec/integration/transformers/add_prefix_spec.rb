# encoding: utf-8

describe Faceter::Builder, "#add_prefix" do

  subject { mapper.new.call input }

  let(:input) do
    [
      {
        id: 1,
        "name" => "joe",
        contacts: [
          {
            "emails" => [
              {
                address: "joe@doe.com",
                "type" => "job"
              }
            ],
            skype: "joe"
          }
        ]
      }
    ]
  end

  let(:output) do
    [
      {
        id: 1,
        "user_name" => "joe",
        user_contacts: [
          {
            "contact.emails" => [
              {
                :"contact.address" => "joe@doe.com",
                "contact.type" => "job"
              }
            ],
            :"contact.skype" => "joe"
          }
        ]
      }
    ]
  end

  let(:mapper) do
    Class.new(Faceter::Mapper) do
      list do
        add_prefix "user", except: :id

        field :user_contacts do
          add_prefix "contact", separator: ".", nested: true
        end
      end
    end
  end

  it "works" do
    expect(subject).to eql output
  end

end # describe Faceter::Builder#add_prefix
