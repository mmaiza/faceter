module Faceter

  module AST

    # The node describes renaming a key of tuples
    #
    # @api private
    #
    class Rename < Node

      # @!scope class
      # @!method new(key, to:)
      # Istantiates the node
      #
      # @example
      #   Faceter::AST::Rename.new :bar, to: :foo
      #
      # @param [String, Symbol] key
      #   The old name of the field to be renamed
      # @option [String, Symbol] :to
      #   The new name of the field
      #
      # @return [Faceter::AST::Rename]

      # @private
      def initialize(key, to:)
        @transproc = Transproc[:rename_keys, key => to]
        super()
      end

    end # class Rename

  end # module AST

end # module Faceter
