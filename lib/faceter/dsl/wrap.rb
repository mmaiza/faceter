module Faceter

  module DSL

    # The node describes wrapping values or parts of hashes into nested tuples
    #
    # @api private
    #
    class Wrap < Node

      # @!scope class
      # @!method new(*keys, options)
      # Creates the node
      #
      # @example
      #   Faceter::DSL::Wrap.new from: :foo, only: [:bar, :baz]
      #   Faceter::DSL::Wrap.new from: :foo, except: :qux
      #
      # @param [Hash] options
      # @option options [Object] :from
      #   The required key of the tuple to take a value from
      # @option options [Object, Array<Object>] :only
      #   The optional white list of keys that should only be extracted
      # @option options [Object, Array<Object>] :except
      #   The optional black list of keys that should be left in a tuple
      #
      # @return [Faceter::DSL::Wrap]

      # @private
      def initialize(*keys, **options)
        @options = options.dup
        @key     = options.fetch(:to)
        @options.delete(:to)
        super
      end

      # Transformer function, defined by the node
      #
      # @return [Transproc::Function]
      #
      def transproc
        Functions[:wrap, @key, @options]
      end

    end # class Wrap

  end # module DSL

end # module Faceter
