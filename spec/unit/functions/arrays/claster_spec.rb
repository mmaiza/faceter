# encoding: utf-8

require "shared/functions"

describe Faceter::Functions::Arrays, "#claster" do

  it_behaves_like "transforming immutable data" do
    let(:arguments) { [:claster] }

    let(:input)  { [1, 1.0, 2, 2, 1.0, 1, 1]       }
    let(:output) { [[1, 1.0], [2, 2], [1.0, 1, 1]] }
  end

end # describe Faceter::Functions::Arrays#claster
