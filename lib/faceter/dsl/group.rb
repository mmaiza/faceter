module Faceter

  module DSL

    # The node describes grouping fields from tuples into nested arrays
    #
    # @api private
    #
    class Group < Node

      # @!scope class
      # @!method new(*keys, options)
      # Creates the node
      #
      # @example
      #   Faceter::DSL::Group.new :bar, :baz, to: :foo
      #
      # @param [Array<String, Symbol>] keys
      #   The list of keys to be grouped
      # @param [Hash] options
      # @option options [String, Symbol] :to
      #   The name of the group to be created
      #
      # @return [Faceter::DSL::Group]

      # @private
      def initialize(*keys, **options)
        @keys = keys.flatten
        @name = options.fetch(:to)
        super
      end

      # Transformer function, defined by the node
      #
      # @return [Transproc::Function]
      #
      def transproc
        Functions[:group, @name, @keys]
      end

    end # class Group

  end # module DSL

end # module Faceter
