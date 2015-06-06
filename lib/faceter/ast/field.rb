module Faceter

  module AST

    # A composition node that describes field of tuple with field-specific data
    #
    # Contains both DSL methods for adding leafs to the AST.
    #
    # @api private
    #
    class Field < Root

      # @!field [r] name
      #
      # @return [String, Symbol] The name (key) of the field
      #
      attr_reader :name

      # @private
      def initialize(name)
        @name = name
        super()
      end

      # Builds a transproc function for the field node from its child nodes
      #
      # @return [Transproc::Function]
      #
      def transproc
        Transproc[:map_value, name, super]
      end

      # Compares the field to another node at the same level of AST
      #
      # Two fields are equal and can be merged iff they have the same name.
      # The following examples are equivalent:
      #
      # @param [Faceter::AST::Node] other
      #
      # @return [Boolean]
      #
      def ==(other)
        other.instance_of?(self.class) && name.equal?(other.name)
      end

    end # class Field

  end # module AST

end # module Faceter
