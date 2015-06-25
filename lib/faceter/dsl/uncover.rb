module Faceter

  module DSL

    # The node describes exclusion of the field from a tuple
    #
    # @api private
    #
    class Uncover < Node

      # @!scope class
      # @!method new(options)
      # Creates the node
      #
      # @example
      #   Faceter::DSL::Uncover.new from: 'foo'
      #
      # @param [Hash] options
      # @option options [Object] :from
      #   The from which a value should be uncovered
      #
      # @return [Faceter::DSL::Uncover]

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

    end # class Uncover

  end # module DSL

end # module Faceter
