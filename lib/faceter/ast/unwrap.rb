module Faceter

  module AST

    # The node describes unwrapping values from the nested tuples
    # either fully or partially.
    #
    # @api private
    #
    class Unwrap < Node

      # @!scope class
      # @!method new(*keys, from:)
      # Istantiates the node
      #
      # @example
      #   Faceter::AST::Unwrap.new :bar, :baz, from: :foo
      #   Faceter::AST::Unwrap.new from: :foo
      #
      # @param [Array<String, Symbol>] keys
      #   The *optional* list of keys to be extracted from the tuple
      # @option [String, Symbol] :from
      #   The key of the tuple to take a value from
      #
      # @return [Faceter::AST::Unwrap]

      # @private
      def initialize(*keys, from:)
        @transproc = Transproc[:ungird, from, keys]
        super()
      end

    end # class Unwrap

  end # module AST

end # module Faceter
