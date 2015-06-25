# encoding: utf-8

module Faceter

  module Functions

    # Transformations of arrays
    #
    module Arrays

      extend Transproc::Registry

      # Breaks array into sequences of consecutive values
      # that are equal (but not nesessarily equivalent) to each other.
      #
      # @example
      #   fn = Arrays[:claster]
      #   fn[[1, 1, 2, 2, 1, 1]]
      #   # => [[1, 1], [2, 2], [1, 1]]
      #
      # @param [Array] array
      #
      # @return [Array<Array>]
      #
      def claster(array)
        array[1..-1].each_with_object([[array.first]]) do |item, ary|
          (ary.last.last == item) ? (ary.last << item) : (ary << [item])
        end
      end

    end # module Arrays

  end # module Functions

end # module Faceter
