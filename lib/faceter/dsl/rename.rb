module Faceter

  module DSL

    # The node describes renaming a key of tuples
    #
    # @api private
    #
    class Rename < Node

      # @!scope class
      # @!method new(key, options)
      # Creates the node
      #
      # @example
      #   Faceter::DSL::Rename.new :bar, to: :foo
      #
      # @param [String, Symbol] key
      #   The old name of the field to be renamed
      # @param [Hash] options
      # @option options [String, Symbol] :to
      #   The new name of the field
      #
      # @return [Faceter::DSL::Rename]

      # @private
      def initialize(key, **options)
        @key  = key
        @name = options.fetch(:to)
        super
      end

      # Checks if the transformation node does something
      #
      # @return [self] itself
      #
      # @raise [Faceter::Error] if the transformation does nothing
      #
      def finalize
        fail Error.new(self) if @key.equal? @name
        self
      end

      # Transformer function, defined by the node
      #
      # @return [Transproc::Function]
      #
      def transproc
        Functions[:rename_keys, @key => @name]
      end

    end # class Rename

  end # module DSL

end # module Faceter
