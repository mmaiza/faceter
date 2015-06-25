# encoding: utf-8

require "transproc/conditional"
require "transproc/recursion"

module Faceter

  module Functions

    # Conditional transformations
    #
    module Conditionals

      extend Transproc::Registry

      uses :is,        from: Transproc::Conditional
      uses :recursion, from: Transproc::Recursion

      # Returns the argument
      #
      # @example
      #   fn =Conditionals[:itself]
      #   fn[100] # => 100
      #
      # @param [Object] value
      #
      # @return [Object]
      #
      def itself(value)
        value
      end

      # Execute the function with value, or its subvalues under given keys
      #
      # @overload execute(value, fn)
      #   Executes a function with given value
      #
      #   @example
      #     fn = Conditionals[:execute, -> v { v.reverse }]
      #     fn["foo"] # => "oof"
      #
      #   @param [Object] value
      #   @param [Proc] fn
      #
      #   @return [Object]
      #
      # @overload execute(hash, fn, keys)
      #   Executes a function with values under given keys of the hash
      #
      #   @example
      #     fn = Conditionals[:execute, -> v { v.reverse }, [:foo]]
      #     fn[{ foo: "FOO" }] # => "OOF"
      #
      #   @param [Hash] hash
      #   @param [Proc] fn
      #   @param [Object, Array<Object>] keys
      #
      #   @return [Object]
      #
      def execute(value, fn, keys = nil)
        args =
          if keys.nil?
            value
          elsif keys.instance_of? Array
            value.values_at(*keys)
          else
            value[keys]
          end
        fn.call(args)
      end

      # Applies proc to the source and merges the result to it
      #
      # If key is given treats the source as hash and merges the result of proc
      # to the hash under given key. Otherwise returns the result of the proc.
      #
      # @example
      #   proc = -> value { :BAZ }
      #   source = { foo: :FOO }
      #
      #   fn = Conditionals[:merge, :foo, proc]
      #   fn[source] # => { foo: :BAZ }
      #
      #   fn = Conditionals[:merge, :bar, proc]
      #   fn[source] # => { foo: :FOO, bar: :BAZ }
      #
      #   fn = Conditionals[:merge, nil, proc]
      #   fn[source] # => :BAZ
      #
      # @overload merge(source, proc, key)
      #
      #   @param [Hash] source
      #   @param [Proc] proc
      #   @param [Object] key
      #
      #   @return [Hash] The source with merged result of the proc
      #
      # @overload merge(source, proc)
      #
      #   @param [Object] source
      #   @param [Proc] proc
      #
      #   @return [Object] The result of the proc
      #
      def merge(source, proc, key = nil)
        value = proc.call(source)
        key ? source.merge(key => value) : value
      end

      # Applies given transformation to the hash
      #
      # If a second argument is set to true, does it recursively for
      # nested levels of data
      #
      # @param [Object] data
      # @param [Boolean] nested
      # @param [Transproc::Function] fn
      #
      # @return [Object] transformed data
      #
      def apply_to_hash(data, nested, fn)
        ops = t(:is, Hash, fn)
        ops = t(:recursion, ops) if nested
        ops[data]
      end

    end # module Conditionals

  end # module Functions

end # module Faceter
