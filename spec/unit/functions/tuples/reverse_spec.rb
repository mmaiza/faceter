# encoding: utf-8

require "shared/functions"

describe Faceter::Functions::Tuples, "#reverse" do

  it "takes empty hash by default" do
    expect(described_class.reverse).to eql described_class.reverse({})
  end

  it_behaves_like "transforming immutable data" do
    let(:arguments) { [:reverse] }

    let(:input)  { {}             }
    let(:output) { { except: [] } }
  end

  it_behaves_like "transforming immutable data" do
    let(:arguments) { [:reverse] }

    let(:input)  { { only: :foo }   }
    let(:output) { { except: :foo } }
  end

  it_behaves_like "transforming immutable data" do
    let(:arguments) { [:reverse] }

    let(:input)  { { except: :foo } }
    let(:output) { { only: :foo }   }
  end

  it_behaves_like "transforming immutable data" do
    let(:arguments) { [:reverse] }

    let(:input)  { { except: [:foo, :bar] } }
    let(:output) { { only: [:foo, :bar] }   }
  end

  it_behaves_like "transforming immutable data" do
    let(:arguments) { [:reverse] }

    let(:input)  { { except: [:foo, :bar] } }
    let(:output) { { only: [:foo, :bar] }   }
  end

  it_behaves_like "transforming immutable data" do
    let(:arguments) { [:reverse] }

    let(:input)  { { except: [:foo, :bar], only: [:baz, :qux] } }
    let(:output) { { except: [:baz, :qux] }                     }
  end

end # describe Faceter::Functions::Tuples#reverse
