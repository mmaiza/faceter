# encoding: utf-8

require "shared/functions"

describe Faceter::Functions::Keys, "#drop_prefix" do

  it_behaves_like "transforming immutable data" do
    let(:arguments) { [:drop_prefix, "foo", "."] }

    let(:input)  { "foo.bar" }
    let(:output) { "bar"     }
  end

  it_behaves_like "transforming immutable data" do
    let(:arguments) { [:drop_prefix, "foo", "."] }

    let(:input)  { "foo." }
    let(:output) { ""     }
  end

  it_behaves_like "transforming immutable data" do
    let(:arguments) { [:drop_prefix, "foo", "."] }

    let(:input)  { "baz_bar" }
    let(:output) { "baz_bar" }
  end

  it_behaves_like "transforming immutable data" do
    let(:arguments) { [:drop_prefix, "foo", "."] }

    let(:input)  { :foo_bar  }
    let(:output) { "foo_bar" }
  end

end # describe Faceter::Functions::Keys#drop_prefix
