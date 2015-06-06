# encoding: utf-8

module Faceter

  # Class Builder carries the AST and uses DSL methods to add new nodes to it.
  #
  # Builder instance is initialized either with a root of the AST
  # (a `Faceter::AST::Root` node), or with a subtree node.
  # Then it uses DSL methods to add new child nodes to that tree.
  #
  # DSL methods are just a thin wrappers about one of two methods: `add_branch`
  # and `add_leaf`, that define how to add nodes to the AST.
  #
  # @example
  #   list = List.new
  #   builder = Builder.new(list)
  #   builder.tree
  #   # => #<Faceter::AST::List @nodes=[]>
  #
  #   builder.rename :foo, to: :bar
  #   builder.tree
  #   # => #<Faceter::AST::List
  #   #      @nodes=[#<Faceter::AST::Rename @old_name=:foo @new_name=:bar>]
  #   #    >
  #
  class Builder

    extend Faceter::DSL # provides the `defines` helper method

    # @!attribute [r] tree
    #
    # @return [Faceter::Node] the AST being populated with nodes
    #
    attr_reader :tree

    # @private
    def initialize(tree = Faceter::AST::Root.new)
      @tree = tree.dup
    end

    # DSL methods for adding specific nodes to AST
    #
    # Every DSL method calls either `add_branch`, or `add_leaf` with a
    # corresponding node type
    #
    defines %w(
      add_prefix create exclude field group list remove_prefix rename
      stringify_keys symbolize_keys ungroup unwrap wrap
    )

    # Finalizes AST by merging branches that describe the same level of nesting
    #
    # @return [Faceter::AST::Root] the compacted tree
    #
    def finalize
      tree.finalize
    end

    private

    # Adds a branch node of given type to the AST with a block,
    # where subnodes should be defined.
    #
    # @example
    #   builder.add_brahcn List do |list|
    #     list.add_leaf SymbolizeKeys
    #   end
    #
    # @param [Faceter::AST::Root] type
    # @param [Array] args The arguments for the node
    # @param [Proc] block
    #
    # @yield the block
    #
    # @return [Faceter::AST::Root] the current tree populated with a new node
    #
    # @raise [ArgumentError] if no block given
    #
    def add_branch(type, *args, &block)
      child = self.class.new(type.new(*args))
      child.instance_exec(&block)
      tree << child.tree.valid
    end

    # Adds a leaf node describing transformation to the AST
    #
    # @example
    #   builder.add_leaf SymbolizeKeys
    #
    # @param [Faceter::AST::Node] type
    # @param [Array] args The arguments for the node
    # @param [Proc] block
    #
    # @return [Faceter::AST::Root] the current tree populated with a new node
    #
    def add_leaf(type, *args, &block)
      tree << type.new(*args, &block)
    end

  end # class Builder

end # module Faceter
