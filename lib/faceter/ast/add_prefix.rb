module Faceter

  module AST

    # The node describes adding prefix from tuples' keys
    #
    # @api private
    #
    class AddPrefix < Node

      # @!scope class
      # @!method new(prefix, separator: "_", nested: false)
      # Istantiates the node
      #
      # @example
      #   Faceter::AST::AddPrefix.new "user", separator: ".", nested: true
      #
      # @param [Array<String>] prefix
      #   The prefix to be added to keys
      # @option [String] :separator ("_")
      #   The separator to be added along with the prefix
      # @option [Boolean] :nested (false)
      #   Whether the prefix should be added to keys at all nested layers
      #
      # @return [Faceter::AST::AddPrefix]

      # @private
      def initialize(prefix, separator: "_", nested: nil)
        funn = Transproc[:add_prefix, prefix, separator]
        fun  = Transproc[:keep_symbol, funn]
        fn   = Transproc[:map_keys, fun]
        @transproc = Transproc[:apply_to_hash, nested, fn]
        super()
      end

    end # class AddPrefix

  end # module AST

end # module Faceter
