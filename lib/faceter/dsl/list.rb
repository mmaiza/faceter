module Faceter

  module DSL

    # A compose node that describes array of tuples
    #
    # Defines a specific transproc builder that applies transprocs from
    # all nodes to any value in the array
    #
    class List < Branch

      # Builds a transproc function for the node from its child nodes
      #
      # @return [Functions::Function]
      #
      def transproc
        Functions[:map_array, super]
      end

    end # class List

  end # module DSL

end # module Faceter
