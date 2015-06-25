# encoding: utf-8

require "transproc"

module Faceter

  module Functions

    # Transformations of value keys (either strings or symbols)
    #
    module Keys

      extend Transproc::Registry

      # Applies the function to the source and converts the result to symbol
      # if the source data was a symbol. Otherwise returns a string.
      #
      # @param [String, Symbol] source
      # @param [Transproc::Function] fn
      #
      # @return [String, Symbol]
      #
      def keep_symbol(source, fn)
        data = fn.call(source)
        source.instance_of?(Symbol) ? data.to_sym : data
      end

      # Adds the prefix with separator to the name
      #
      # @example
      #   fn = Keys[:add_prefix, "foo", "."]
      #   fn["bar"] # => "foo.bar"
      #
      # @param [String, Symbol] name
      # @param [String, Symbol] prefix
      # @param [String, Symbol] separator
      #
      # @return [String]
      #
      def add_prefix(name, prefix, separator)
        "#{prefix}#{separator}#{name}"
      end

      # Removes the prefix with separator from the name
      #
      # @example
      #   fn = Keys[:drop_prefix, "foo", "."]
      #   fn["foo.bar"]  # => "bar"
      #
      # @param [String, Symbol] name
      # @param [String, Symbol] prefix
      # @param [String, Symbol] separator
      #
      # @return [String]
      #
      def drop_prefix(name, prefix, separator)
        string = name.to_s
        affix  = "#{prefix}#{separator}"
        first  = string.start_with?(affix) ? affix.length : 0

        string[first..-1]
      end

    end # module Keys

  end # module Functions

end # module Faceter
