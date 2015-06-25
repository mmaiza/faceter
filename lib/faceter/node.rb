module Faceter

  # An immutable node of the abstract syntax tree (AST), that describes
  # either some "end-up" transformation, or a level of nested input data.
  #
  # Every node is expected to accept attributes and (possibly) block, and
  # implement the following methods:
  #
  # * `#finalize` that locally validates the node after the tree has been built;
  #   Such a pending validation allows building a tree using DSL commands
  #   step-by-step, and check the result only before instantiating a mapper.
  #
  # * `#transproc` that, in its turn, implements the `#call` method to
  #   transform input data to the output.
  #
  # Nodes describe only the structure of AST, they know
  # neither how to build the tree with DSL (see [Faceter::Builder]),
  # nor how to optimize it later (see [Faceter::Optimizer]).
  #
  class Node

    # Defines if nodes of the current type can have subnodes
    #
    # @return [Boolean]
    #
    def self.branch?
      false
    end

    # @!attribute [r] attributes
    #
    # @return [Array] The list of node-specific attributes
    #
    attr_reader :attributes

    # @!method transproc
    # The transformation function for the branch
    #
    # @abstract
    #
    def transproc; end

    # @private
    def initialize(*attributes)
      @attributes = attributes
      freeze
    end

    # Return a node after some optimization
    #
    # @return [Faceter::Node]
    #
    def finalize
      self
    end

    # Returns a human-readable string representating the node
    #
    # @return [String]
    #
    def inspect
      "<#{self}>"
    end

    # Converts the node into string with its name and attributes
    #
    # @return [String]
    #
    def to_s
      "#{__name__}(#{attributes.map(&:inspect).join(", ")})"
    end

    private

    def __name__
      self.class.name.split("::").last
    end

  end # class Node

end # module Faceter
