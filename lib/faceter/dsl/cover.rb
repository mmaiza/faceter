module Faceter

  module DSL

    # The node describes exclusion of the field from a tuple
    #
    # @api private
    #
    class Cover < Node

      # @!scope class
      # @!method new(options)
      # Creates the node
      #
      # @example
      #   Faceter::DSL::Cover.new to: 'foo'
      #
      # @param [Hash] options
      # @option options [Object] :to
      #   The key under which a value should be placed to hash
      #
      # @return [Faceter::DSL::Cover]

      # @private
      def initialize(**options)
        @key = options.fetch(:to)
        super
      end

      # Transformer function, defined by the node
      #
      # @return [Transproc::Function]
      #
      def transproc
        Transproc::Function.new proc { |value| { @key => value } }, {}
      end

    end # class Cover

  end # module DSL

end # module Faceter
