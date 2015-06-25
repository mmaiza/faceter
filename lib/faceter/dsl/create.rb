module Faceter

  module DSL

    # The node describes creating a new value from values by keys
    #
    # @api private
    #
    class Create < Node

      # @!scope class
      # @!method new(name = nil, options, &block)
      # Creates the node
      #
      # @example
      #   Faceter::DSL::Create.new :foo, from: [:bar, :baz] do |bar, baz|
      #     bar + baz
      #   end
      #
      # @param [String, Symbol] name
      #   The optional name for the new key
      #   When skipped, the resulting value will rewrite the whole tuple
      # @param [Hash] options
      # @option options [nil, String, Symbol, Array<String, Symbol>] :from (nil)
      #   The list of keys to take values from
      #   When skipped, the whole tuple will be send to the block
      # @param [Proc] block
      #   The block in which the new value should be created
      #
      # @yieldparam
      #   Either the list of values by given keys, or the whole tuple
      #
      # @return [Faceter::DSL::Create]

      # @private
      def initialize(name = nil, **options, &block)
        @name    = name
        @block   = block
        @coercer = block_given? ? block : Functions[:itself]
        @keys    = options.fetch(:from)
        super
      end

      # Checks if the transformation node does something
      #
      # @return [self] itself
      #
      # @raise [Faceter::Error] if the transformation does nothing
      #
      def finalize
        fail Error.new(self) if @name.equal?(@keys) && !@block
        self
      end

      # Transformer function, defined by the node
      #
      # @return [Transproc::Function]
      #
      def transproc
        function = Functions[:execute, @coercer, @keys]
        Functions[:merge, function, @name]
      end

    end # class Create

  end # module DSL

end # module Faceter
