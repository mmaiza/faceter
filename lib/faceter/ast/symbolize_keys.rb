module Faceter

  module AST

    # The node describes symbolizing keys of tuple (and its nested tuples)
    #
    # @api private
    #
    class SymbolizeKeys < Node

      # @!scope class
      # @!method new(nested: true)
      # Istantiates the node
      #
      # @example
      #   Faceter::AST::SymbolizeKeys.new nested: false
      #
      # @option [Boolean] nested: true
      #   Whether keys should be symbolized at the nested levels
      #
      # @return [Faceter::AST::SymbolizeKeys]

      # @private
      def initialize(nested: true)
        fn = Transproc[:symbolize_keys]
        @transproc = Transproc[:apply_to_hash, nested, fn]
        super()
      end

    end # class SymbolizeKeys

  end # module AST

end # module Faceter
