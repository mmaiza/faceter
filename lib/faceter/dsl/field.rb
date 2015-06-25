module Faceter

  module DSL

    # A composition node that describes field of tuple with field-specific data
    #
    # Contains both DSL methods for adding leafs to the AST.
    #
    # @api private
    #
    class Field < Branch

      # @!scope class
      # @!method new(name)
      # Creates the branch
      #
      # @example
      #   Faceter::DSL::Field.new(:foo)
      #
      # @param [Symbol, String] name
      #   The name of the field (a tuple key)
      #
      # @return [Faceter::DSL::Field]

      # @private
      def initialize(name)
        @name = name
        super
      end

      # Builds a transproc function for the field node from its child nodes
      #
      # @return [Functions::Function]
      #
      def transproc
        Functions[:map_value, @name, super]
      end

    end # class Field

  end # module DSL

end # module Faceter
