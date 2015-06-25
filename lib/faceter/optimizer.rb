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
  # @todo:
  #   To do more node-specific optimizations, the optimizer should be
  #   kind of a DSL-specific visitor, that applies the rules to
  #   subnodes of every branch in the tree.
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

    # @private
    def initialize(tree)
      @tree = tree
      freeze
    end

    # @!attribute [r] tree
    #
    # @return [Faceter::Branch] The AST to be optimized
    #
    attr_reader :tree

    # Returns the optimized AST
    #
    # @return [Faceter::Branch]
    #
    # @todo The method should be implemented and covered
    #
    def call
      tree
    end

  end # class Optimizer

end # module Faceter
