# encoding: utf-8

require "shared/functions"

describe Faceter::Functions::Conditionals, "#itself" do

  it_behaves_like "transforming immutable data" do
    let(:arguments) { [:itself] }

    let(:input)  { :foo }
    let(:output) { :foo }
  end

end # describe Faceter::Functions::Conditionals#itself
