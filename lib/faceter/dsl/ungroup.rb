module Faceter

  module DSL

    # The node describes ungrouping values from the nested tuples
    # either fully or partially.
    #
    # @api private
    #
    class Ungroup < Node

      # @!scope class
      # @!method new(*keys, options)
      # Creates the node
      #
      # @example
      #   Faceter::DSL::Ungroup.new :bar, :baz, from: :foo
      #   Faceter::DSL::Ungroup.new from: :foo
      #
      # @param [Array<String, Symbol>] keys
      #   The *optional* list of keys to be extracted from the tuple
      # @param [Hash] options
      # @option options [String, Symbol] :from
      #   The key of the nested array to take values from
      #
      # @return [Faceter::DSL::Ungroup]

      # @private
      def initialize(*keys, **options)
        @keys = keys.flatten
        @name = options.fetch(:from)
        super
      end

      # Transformer function, defined by the node
      #
      # @return [Transproc::Function]
      #
      def transproc
        Functions[:ungroup, @name, @keys]
      end

    end # class Ungroup

  end # module DSL

end # module Faceter
