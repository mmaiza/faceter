# encoding: utf-8

require "shared/functions"

describe Faceter::Functions::Keys, "#add_prefix" do

  it_behaves_like "transforming immutable data" do
    let(:arguments) { [:add_prefix, "foo", "."] }

    let(:input)  { "bar"     }
    let(:output) { "foo.bar" }
  end

end # describe Faceter::Functions::Keys#add_prefix
