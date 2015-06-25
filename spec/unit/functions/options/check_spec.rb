# encoding: utf-8

require "shared/functions"

describe Faceter::Functions::Options, "#check" do

  it_behaves_like "transforming immutable data" do
    let(:arguments) { [:check] }

    let(:input)  { :foo }
    let(:output) { true }
  end

  it_behaves_like "transforming immutable data" do
    let(:arguments) { [:check, only: [:foo, :bar]] }

    let(:input)  { :foo }
    let(:output) { true }
  end

  it_behaves_like "transforming immutable data" do
    let(:arguments) { [:check, except: :bar] }

    let(:input)  { :foo }
    let(:output) { true }
  end

  it_behaves_like "transforming immutable data" do
    let(:arguments) { [:check, only: [:bar, :baz]] }

    let(:input)  { :foo  }
    let(:output) { false }
  end

  it_behaves_like "transforming immutable data" do
    let(:arguments) { [:check, except: [:foo, :bar]] }

    let(:input)  { :foo  }
    let(:output) { false }
  end

end # describe Faceter::Functions::Options#check
