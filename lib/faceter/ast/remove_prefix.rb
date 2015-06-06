module Faceter

  module AST

    # The node describes removing prefix from tuples' keys
    #
    # @api private
    #
    class RemovePrefix < Node

      # @!scope class
      # @!method new(prefix, separator: "_", nested: false)
      # Istantiates the node
      #
      # @example
      #   Faceter::AST::RemovePrefix.new "user", separator: ".", nested: true
      #
      # @param [Array<String>] prefix
      #   The prefix to be excluded from keys
      # @option [String] :separator ("_")
      #   The separator to be excluded along with the prefix
      # @option [Boolean] :nested (false)
      #   Whether the prefix should be excluded from keys at all nested layers
      #
      # @return [Faceter::AST::RemovePrefix]

      # @private
      def initialize(prefix, separator: "_", nested: nil)
        funn = Transproc[:drop_prefix, prefix, separator]
        fun  = Transproc[:keep_symbol, funn]
        fn   = Transproc[:map_keys, fun]
        @transproc = Transproc[:apply_to_hash, nested, fn]
        super()
      end

    end # class RemovePrefix

  end # module AST

end # module Faceter
