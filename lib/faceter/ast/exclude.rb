module Faceter

  module AST

    # The node describes exclusion of the field from a tuple
    #
    # @api private
    #
    class Exclude < Node

      # @!scope class
      # @!method new(*keys)
      # Istantiates the node
      #
      # @example
      #   Faceter::AST::Exclude.new :bar, :baz
      #
      # @param [Array<String, Symbol>] keys
      #   The list of keys to be excluded from a tuple
      #
      # @return [Faceter::AST::Exclude]

      # @private
      def initialize(*keys)
        @transproc = Transproc[:reject_keys, keys]
        super()
      end

    end # class Exclude

  end # module AST

end # module Faceter
