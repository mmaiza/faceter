module Faceter

  module AST

    # The node describes stringifying keys of tuple (and its nested tuples)
    #
    # @api private
    #
    class StringifyKeys < Node

      # @!scope class
      # @!method new(nested: true)
      # Istantiates the node
      #
      # @example
      #   Faceter::AST::StringifyKeys.new nested: false
      #
      # @option [Boolean] nested: true
      #   Whether keys should be stringified at the nested levels
      #
      # @return [Faceter::AST::StringifyKeys]

      # @private
      def initialize(nested: true)
        fn = Transproc[:stringify_keys]
        @transproc = Transproc[:apply_to_hash, nested, fn]
        super()
      end

    end # class StringifyKeys

  end # module AST

end # module Faceter
