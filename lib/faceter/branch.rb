module Faceter

  # A special type of the composed node, that describes transformation,
  # applied to some level of nested input.
  #
  # Unlike the simple node, describing a transformation of data, the
  # branch carries a collection of subnodes along with methods to [#rebuild]
  # itself with the same attributes and different subnodes.
  #
  # Tne branch only stores subnodes and composes transformations.
  # Its has no access to DSL and knows neither how to build a tree
  # (see [Faceter::Builder]), nor how to optimize it later
  # (see [Faceter::Optimizer]).
  #
  class Branch < Node

    include Enumerable

    # Defines that branches can have subnodes
    #
    # @return [true]
    #
    def self.branch?
      true
    end

    # @!scope class
    # @!method new(*attributes, &block)
    # Creates a new branch
    #
    # @param [Object, Array<Object>] attributes
    #   The list of type-specific attributes of the branch
    # @param [Proc] block
    #   The block that returns an array of subnodes for the branch
    #
    # @return [Branch::Node]

    # @private
    def initialize(*attributes, &block)
      @subnodes = block_given? ? block.call : []
      super
    end

    # Returns a new branch of the same type, with the same attributes,
    # but with a different collection of subnodes, transmitted by the block.
    #
    # @example
    #   branch = Branch.new(:foo)
    #   # => <Branch(:foo) []>
    #   branch.rebuild { Node.new(:bar) }
    #   # => <Branch(:foo) [<Node(:bar)>]>
    #
    # @return [Faceter::Branch]
    #
    # @yield block that returns a collection of subnodes for the new branch
    #
    def rebuild(&block)
      self.class.new(*attributes, &block)
    end

    # @!method each
    # Returns the enumerator for subnodes
    #
    # @return [Enumerator]
    #
    def each(&block)
      @subnodes.each(&block)
    end

    # Returns a new branch with the other node added to its subnodes
    #
    # @param [Faceter::Node] other
    #
    # @return [Faceter::Branch]
    #
    def +(other)
      rebuild { entries << other }
    end

    # The composition of transformations from all subnodes of the branch
    #
    # To be reloaded by the subclasses to apply the composition to
    # a corresponding level of nested data.
    #
    # @return [Transproc::Function]
    #
    # @abstract
    #
    def transproc
      map(&:transproc).inject(:>>)
    end

    # Returns the new branch with subnodes finalized and compacted
    #
    # @param [Array<Faceter::Branch>] branch
    #
    # @return [Array<Faceter::Branch>]
    #
    # @raise [Faceter::Error]
    #   If a branch (at the moment of a mapper's instantiation) has no subnodes,
    #   and is useless because it carries no transformations.
    #
    def finalize
      fail Error.new(self) if none?
      rebuild { map(&:finalize) }
    end

    # Adds subnodes to the default description of the branch
    #
    # @return [String]
    #
    def to_s
      "#{super} [#{map(&:inspect).join(", ")}]"
    end

    private

    # Substitutes the name of the class by the special name "Root"
    # to describe the root node of AST.
    def __name__
      instance_of?(Branch) ? "Root" : super
    end

  end # class Branch

end # module Faceter
