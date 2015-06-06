# encoding: utf-8

module Faceter

  # The module collects various nodes for the AST (Abstract Syntax Tree),
  # that describes the transformation.
  #
  # Nodes in the AST describe:
  # * either the nesting level (`field` or `list`) of data
  # * or a transformation to be applied to those data
  #
  # Nodes that describes levels of data can be nested (has their own nodes),
  # while the transformations serves a leafs of the AST.
  #
  # Nodes also has a `finalize` method to compact subtrees, merging those
  # consecutive branches that describes the same level of nesting.
  # This allows to minimize the number of transproc iteration.
  # Only nested node can be compacted, while all the leafs (transforms)
  # are treated as different from each other.
  #
  # At the end, every node in the AST has its own `transproc` method,
  # that returns a transformer function for its subtree.
  #
  module AST

    # The base class for all nodes in AST
    #
    class Node

      include ::Transproc::Helper # defines `#t` shortcut for transprocs

      # Describes whether the node is a nesting branch, or a simple node
      #
      # @return [Boolean]
      #
      def self.branch?
        false
      end

      # @!field [r] transproc
      #
      # @return [::Transproc::Function]
      #   The function that makes a transformation, described by given node
      #   and its subtree.
      #
      attr_reader :transproc

      # Optimizes the current node of the branch and returns the result
      #
      # @abstract
      #
      def finalize
        self
      end

    end # class Node

    # The base class for nested nodes (fields and lists) in the AST
    #
    # @abstract
    #
    class Root < Node

      include ::Transproc::Composer  # defines `compose` method
      include Comparable

      # @!attribute [r] nodes
      #
      # @return [Array<Faceter::AST::Node>]
      #   The subtree (child nodes) of the current node
      #
      attr_reader :nodes

      # @private
      def initialize
        @nodes = []
      end

      # Adds new (sub)nodes to the end of the list of branches
      #
      # @param [Faceter::AST::Node, Array<Faceter::AST::Node>] list
      #   One or more subnodes to be added
      #
      # @return [self] itself
      #
      def <<(*list)
        @nodes += list.flatten
        self
      end

      # Describes whether the node is a nesting branch, or a simple node
      #
      # @return [true]
      #
      def self.branch?
        true
      end

      # Composition of the nodes' transprocs
      #
      # @return [::Transproc::Function]
      #
      def transproc
        compose { |fns| nodes.map(&:transproc).each(&fns.method(:<<)) }
      end

      # Checks if a branch has nodes
      #
      # @return [self] itself
      #
      # @raise [Faceter::NestingError] if the branch has no nodes
      #
      def valid
        nodes.any? ? self : fail(NestingError)
      end

      # Optimizes the list of nodes by merging equal ones
      #
      # @return [undefined]
      #
      def finalize
        compact
        nodes.each(&:finalize)
        super
      end

      # Compares two nodes at the one level of nesting
      #
      # Any leaf nodes (that describe transformations) are treated as different,
      # and cannot be merged to each other
      #
      # @param [Faceter::AST::Node] other
      #
      # @return [Boolean] +false+
      #
      def ==(other)
        false
      end

      private

      # Merges equal consecutive nodes of the current node
      #
      # Every merged node contains subtrees from all nodes being merged to it
      #
      # @return [undefined]
      #
      def compact
        @nodes = Transproc[:classify][nodes].map do |node, dups|
          node.class.branch? ? (node << dups.map(&:nodes)) : node
        end
      end

    end # class Root

  end # module AST

end # module Faceter
