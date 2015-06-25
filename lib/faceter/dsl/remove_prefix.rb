module Faceter

  module DSL

    # The node describes removing prefix from tuples' keys
    #
    # @api private
    #
    class RemovePrefix < Node

      # @!scope class
      # @!method new(prefix, options)
      # Creates the node
      #
      # @example
      #   Faceter::DSL::RemovePrefix.new "user", separator: ".", nested: true
      #
      # @param [Array<String>] prefix
      #   The prefix to be excluded from keys
      # @param [Hash] options
      # @option options [String] :separator ("_")
      #   The separator to be excluded along with the prefix
      # @option options [Boolean] :nested (false)
      #   Whether the prefix should be excluded from keys at all nested layers
      #
      # @return [Faceter::DSL::RemovePrefix]

      # @private
      def initialize(prefix, **options)
        @prefix    = prefix
        @options   = options
        @separator = options.fetch(:separator, "_")
        @nested    = options.fetch(:nested, nil)
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
        Functions[:map_keys, __filtered_key_function____]
      end

      def __filtered_key_function____
        Functions[:guard, Functions[:check, @options], __key_function__]
      end

      def __key_function__
        Functions[:keep_symbol, Functions[:drop_prefix, @prefix, @separator]]
      end

    end # class RemovePrefix

  end # module DSL

end # module Faceter
