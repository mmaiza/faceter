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
        @options   = options
        super
      end

      # Transformer function, defined by the node
      #
      # @return [Transproc::Function]
      #
      def transproc
        Functions[:apply_to_hash, @nested, __hash_function__]
      end

      private

      def __hash_function__
        Functions[:map_keys, __filtered_key_function__]
      end

      def __filtered_key_function__
        Functions[:guard, Functions[:check, @options], __key_function__]
      end

      def __key_function__
        Functions[:keep_symbol, Functions[:add_prefix, @prefix, @separator]]
      end

    end # class AddPrefix

  end # module DSL

end # module Faceter
