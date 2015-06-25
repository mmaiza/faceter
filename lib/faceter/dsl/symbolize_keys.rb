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
        @nested = options.fetch(:nested, true)
        super
      end

      # Transformer function, defined by the node
      #
      # @return [Transproc::Function]
      #
      def transproc
        function = Functions[:symbolize_keys]
        Functions[:apply_to_hash, @nested, function]
      end

    end # class SymbolizeKeys

  end # module DSL

end # module Faceter
