module Faceter

  module AST

    # The node describes ungrouping values from the nested tuples
    # either fully or partially.
    #
    # @api private
    #
    class Ungroup < Node

      # @!scope class
      # @!method new(*keys, from:)
      # Istantiates the node
      #
      # @example
      #   Faceter::AST::Ungroup.new :bar, :baz, from: :foo
      #   Faceter::AST::Ungroup.new from: :foo
      #
      # @param [Array<String, Symbol>] keys
      #   The *optional* list of keys to be extracted from the tuple
      # @option [String, Symbol] :from
      #   The key of the nested array to take values from
      #
      # @return [Faceter::AST::Ungroup]

      # @private
      def initialize(*keys, from:)
        @transproc = Transproc[:ungroup, from, keys]
        super()
      end

    end # class Ungroup

  end # module AST

end # module Faceter
