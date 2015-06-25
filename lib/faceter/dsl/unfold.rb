module Faceter

  module DSL

    # The node describes exclusion of the field from a tuple
    #
    # @api private
    #
    class Unfold < Node

      # @!scope class
      # @!method new(options)
      # Creates the node
      #
      # @example
      #   Faceter::DSL::Unfold.new from: 'foo'
      #
      # @param [Hash] options
      # @option options [Object] :from
      #   The from which a value should be unfolded
      #
      # @return [Faceter::DSL::Unfold]

      # @private
      def initialize(**options)
        @key = options.fetch(:from)
        super
      end

      # Transformer function, defined by the node
      #
      # @return [Transproc::Function]
      #
      def transproc
        Transproc::Function.new proc { |hash| hash[@key] }, {}
      end

    end # class Unfold

  end # module DSL

end # module Faceter
