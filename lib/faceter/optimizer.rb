# encoding: utf-8

module Faceter

  # The class is responcible for rebuilding the AST and optimizing its structure
  #
  # Its primary goal is compacting branches to exclude repetitive iterations in
  # cases like this:
  #
  #   list do
  #     field :baz do
  #       rename :foo, to: :bar
  #     end
  #   end
  #
  #   list do
  #     field :baz do
  #       rename :baz, to: :qux
  #     end
  #   end
  #
  # that can be merged into:
  #
  #   list do
  #     field :baz do
  #       rename :foo, to: :bar
  #       rename :baz, to: :qux
  #     end
  #   end
  #
  # Optimizer is a node class-agnostic, it backs not on node specificity,
  # but on `attributes` and `each` (subnodes) methods, defined for every
  # branch.
  #
  # @api private
  #
  class Optimizer

    # Initializes the optimizer and returns the optimized tree
    #
    # @param (see .new)
    #
    # @return (see #call)
    #
    def self.[](tree)
      new(tree).call
    end

    # @!scope class
    # @!method new(tree)
    # Creates the optimizer for given AST
    #
    # @param [Faceter::Branch] tree
    #   The finalized (valid) tree to optimize
    #
    # @return [Faceter::Optimizer]
    #
    # @private
    #
    def initialize(tree)
      @tree = tree
      freeze
    end

    # Returns the optimized AST
    # @todo Not yet implemented
    #
    # @return [Faceter::Branch]
    #
    def call
      @tree
    end

  end # class Optimizer

end # module Faceter
