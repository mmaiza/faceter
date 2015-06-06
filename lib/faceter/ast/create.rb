module Faceter

  module AST

    # The node describes creating a new value from values by keys
    #
    # @api private
    #
    class Create < Node

      # @!scope class
      # @!method new(name = nil, from: [], &block)
      # Istantiates the node
      #
      # @example
      #   Faceter::AST::Create.new :foo, from: [:bar, :baz] do |bar, baz|
      #     bar + baz
      #   end
      #
      #   Faceter::AST::Create.new from: [:bar, :baz] do |bar, baz|
      #     bar + baz
      #   end
      #
      #   Faceter::AST::Create.new :foo do |tuple|
      #     tuple
      #   end
      #
      #   Faceter::AST::Create.new do |tuple|
      #     tuple.values.first
      #   end
      #
      # @param [String, Symbol] name
      #   The optional name for the new key
      #   When skipped, the resulting value will rewrite the whole tuple
      # @option [Array<String, Symbol>] from: []
      #   The list of keys to take values from
      #   When skipped, the whole tuple will be send to the block
      # @param [Proc] block
      #   The block in which the new value should be created
      #
      # @yieldparam
      #   Either the list of values by given keys, or the whole tuple
      #
      # @return [Faceter::AST::Create]

      # @private
      def initialize(name = nil, from: [], &block)
        @transproc = Transproc[:merge, Transproc[:apply, block, from], name]
        super()
      end

    end # class Create

  end # module AST

end # module Faceter
