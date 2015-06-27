# encoding: utf-8

module Faceter

  # Builds the immutable abstract syntax tree (AST) using DSL commands.
  #
  # Defines the [#transproc] method to return a transformation function,
  # described by the optimized AST.
  #
  # @example
  #   builder = Builder.new do
  #     field :user do     # DSL method
  #       add_prefix :user # DSL method for subtree
  #     end
  #   end
  #
  #   tree.finalize
  #   # => <Root() [<Field(:user) [<AddPrefix(:user)>]>]>
  #
  class Builder

    # @private
    def initialize(tree = Branch.new, &block)
      @tree = tree
      instance_eval(&block) if block_given? # applies DSL command to the @tree
      freeze
    end

    # @!attribute [r] tree
    #
    # @return [Faceter::Branch] The root node of the AST
    #
    attr_reader :tree

    # Returns the finalized (valid) AST after build
    #
    # @return [Faceter::Branch]
    #
    # @raise [Error] When the tree contains invalid (useless) branches
    #
    def finalize
      tree.finalize
    end

    private

    # Forwards all DSL commands to the [#__add__] method
    def method_missing(name, *args, &block)
      __add__(DSL.commands[name], *args, &block)
    end

    def respond_to_missing?(name, *)
      DSL.command? name
    end

    # Factory method, that knows how to add any node to the tree
    def __add__(type, *args, &block)
      builder = type.branch? ? :__branch__ : :__node__
      @tree += __send__(builder, type, *args, &block)
    end

    # Adds a branch (Field, List) to the tree
    def __branch__(type, *args, &block)
      self.class.new(__node__(type, *args), &block).tree
    end

    # Adds a simple node to the tree
    def __node__(type, *args, &block)
      type.new(*args, &block)
    end

  end # class Builder

end # module Faceter
