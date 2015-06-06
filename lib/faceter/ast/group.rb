module Faceter

  module AST

    # The node describes grouping fields from tuples into nested arrays
    #
    # @api private
    #
    class Group < Node

      # @!scope class
      # @!method new(*keys, to:)
      # Istantiates the node
      #
      # @example
      #   Faceter::AST::Group.new :bar, :baz, to: :foo
      #
      # @param [Array<String, Symbol>] keys
      #   The list of keys to be grouped
      # @option [String, Symbol] :to
      #   The name of the group to be created
      #
      # @return [Faceter::AST::Group]

      # @private
      def initialize(*keys, to:)
        @transproc = Transproc[:group, to, keys]
        super()
      end

    end # class Group

  end # module AST

end # module Faceter
