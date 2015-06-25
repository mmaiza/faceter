module Faceter

  module DSL

    # The node describes stringifying keys of tuple (and its nested tuples)
    #
    # @api private
    #
    class StringifyKeys < Node

      # @!scope class
      # @!method new(options)
      # Creates the node
      #
      # @example
      #   Faceter::DSL::StringifyKeys.new nested: false
      #
      # @param [Hash] options
      # @option options [Boolean] :nested (true)
      #   Whether keys should be stringified at the nested levels
      #
      # @return [Faceter::DSL::StringifyKeys]

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
        function = Functions[:stringify_keys]
        Functions[:apply_to_hash, @nested, function]
      end

    end # class StringifyKeys

  end # module DSL

end # module Faceter
