module Faceter

  # The module provides the `defines` helper for adding
  # DSL methods to the Builder
  #
  # @api private
  #
  module DSL

    # Defines DSL methods with given names
    #
    # @param [String, Array<String>] names
    #
    # @return [undefined]
    #
    def defines(*names)
      names.flatten.each(&method(:__defines__))
    end

    private

    # Returns the class for the DSL node
    #
    # @param [Symbol] name
    #
    # @return [Class]
    #
    def inflector(name)
      require_relative "ast/#{name}"
      (Transproc[:camelize] >> Transproc[:constantize, AST])[name]
    end

    # Defines the DSL method
    #
    # @param [Symbol] name
    #
    # @return [undefined]
    #
    def __defines__(name)
      node = inflector(name)
      add  = node.branch? ? :add_branch : :add_leaf
      define_method(name) { |*args, &block| __send__(add, node, *args, &block) }
    end

  end # module DSL

end # module Faceter
