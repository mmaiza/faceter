module Faceter

  module AST

    # The node describes wrapping values or parts of hashes into nested tuples
    #
    # @api private
    #
    class Wrap < Node

      # @!scope class
      # @!method new(*keys, to:)
      # Istantiates the node
      #
      # @example
      #   Faceter::AST::Wrap.new :bar, :baz, to: :foo
      #   Faceter::AST::Wrap.new to: :foo
      #
      # @param [Array<String, Symbol>] keys
      #   The list of keys to be wrapped to the tuple
      # @option [String, Symbol] :to
      #   The name of the wrapping field
      #
      # @return [Faceter::AST::Wrap]

      # @private
      def initialize(*keys, to:)
        @transproc = Transproc[:begird, to, keys]
        super()
      end

    end # class Wrap

  end # module AST

end # module Faceter
