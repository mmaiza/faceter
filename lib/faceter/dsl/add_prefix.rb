module Faceter

  module DSL

    # The node describes adding prefix from tuples' keys
    #
    # @api private
    #
    class AddPrefix < Node

      # @!scope class
      # @!method new(prefix, options)
      # Creates the node
      #
      # @example
      #   Faceter::DSL::AddPrefix.new "user", separator: ".", nested: true
      #
      # @param [Array<String>] prefix
      #   The prefix to be added to keys
      # @param [Hash] options
      # @option options [String] :separator ("_")
      #   The separator to be added along with the prefix
      # @option options [Boolean] :nested (false)
      #   Whether the prefix should be added to keys at all nested layers
      #
      # @return [Faceter::DSL::AddPrefix]

      # @private
      def initialize(prefix, **options)
        @prefix    = prefix
        @separator = options.fetch(:separator, "_")
        @nested    = options.fetch(:nested, nil)
        super
      end

      # Transformer function, defined by the node
      #
      # @return [Transproc::Function]
      #
      def transproc
        Functions[:apply_to_hash, @nested, __map_keys__]
      end

      private

      def __add_prefix__
        Functions[:add_prefix, @prefix, @separator]
      end

      def __keep_symbol__
        Functions[:keep_symbol, __add_prefix__]
      end

      def __map_keys__
        Functions[:map_keys, __keep_symbol__]
      end

    end # class AddPrefix

  end # module DSL

end # module Faceter