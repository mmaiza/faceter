module Faceter

  module DSL

    # The node describes symbolizing keys of tuple (and its nested tuples)
    #
    # @api private
    #
    class SymbolizeKeys < Node

      # @!scope class
      # @!method new(options)
      # Creates the node
      #
      # @example
      #   Faceter::DSL::SymbolizeKeys.new nested: false
      #
      # @param [Hash] options
      # @option options [Boolean] :nested (true)
      #   Whether keys should be symbolized at the nested levels
      #
      # @return [Faceter::DSL::SymbolizeKeys]

      # @private
      def initialize(**options)
        @options = options
        @nested  = options.fetch(:nested, true)
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
        -> key { key.to_s.to_sym }
      end

    end # class SymbolizeKeys

  end # module DSL

end # module Faceter
