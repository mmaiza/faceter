module Faceter

  module DSL

    # The node describes unwrapping values from the nested tuples
    # either fully or partially.
    #
    # @api private
    #
    class Unwrap < Node

      # @!scope class
      # @!method new(*keys, options)
      # Creates the node
      #
      # @example
      #   Faceter::DSL::Unwrap.new from: :foo, only: [:bar, :baz]
      #   Faceter::DSL::Unwrap.new from: :foo, except: :qux
      #
      # @param [Hash] options
      # @option options [Object] :from
      #   The required key of the tuple to take a value from
      # @option options [Object, Array<Object>] :only
      #   The optional white list of keys that should only be extracted
      # @option options [Object, Array<Object>] :except
      #   The optional black list of keys that should be left in a tuple
      #
      # @return [Faceter::DSL::Unwrap]

      # @private
      def initialize(**options)
        @options = options.dup
        @key     = options.fetch(:from)
        @options.delete(:from)
        super
      end

      # Transformer function, defined by the node
      #
      # @return [Transproc::Function]
      #
      def transproc
        Functions[:unwrap, @key, @options]
      end

    end # class Unwrap

  end # module DSL

end # module Faceter
