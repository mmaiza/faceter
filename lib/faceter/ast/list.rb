module Faceter

  module AST

    # A compose node that describes array of tuples
    #
    # Defines a specific transproc builder that applies transprocs from
    # all nodes to any value in the array
    #
    class List < Root

      # Builds a transproc function for the node from its child nodes
      #
      # @return [Transproc::Function]
      #
      def transproc
        Transproc[:map_array, super]
      end

      # Compares the list to another node at the same level of AST
      #
      # Any list is equal to another one at the same level of nesting.
      # This means every consecutive lists in AST can be merged,
      # and the following examples equivalent:
      #
      # @param [Faceter::AST::Node] other
      #
      # @return [Boolean]
      #
      def ==(other)
        other.instance_of? self.class
      end

    end # class List

  end # module AST

end # module Faceter
