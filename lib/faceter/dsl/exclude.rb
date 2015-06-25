module Faceter

  module DSL

    # The node describes exclusion of the field from a tuple
    #
    # @api private
    #
    class Exclude < Node

      # @!scope class
      # @!method new(*keys)
      # Creates the node
      #
      # @example
      #   Faceter::DSL::Exclude.new :bar, :baz
      #
      # @param [Array<String, Symbol>] keys
      #   The list of keys to be excluded from a tuple
      #
      # @return [Faceter::DSL::Exclude]

      # @private
      def initialize(*keys, **options)
        @blacklist = keys.any? ? keys.flatten : Array[*options[:only]]
        @whitelist = Array[*options[:except]]
        super
      end

      # Checks if the transformation node does something
      #
      # @return [self] itself
      #
      # @raise [Faceter::Error] if the transformation does nothing
      #
      def finalize
        fail Error.new(self) if @blacklist.empty? && @whitelist.empty?
        self
      end

      # Transformer function, defined by the node
      #
      # @return [Transproc::Function]
      #
      def transproc
        if @whitelist.any?
          Functions[:accept_keys, @whitelist]
        else
          Functions[:reject_keys, @blacklist]
        end
      end

    end # class Exclude

  end # module DSL

end # module Faceter
