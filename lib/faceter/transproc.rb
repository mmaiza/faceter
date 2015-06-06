# encoding: utf-8

require "transproc/conditional"
require "transproc/recursion"

module Faceter

  # Collection of the gem-specific transproc functions
  #
  # @api private
  #
  module Transproc

    extend ::Transproc::Registry
    extend ::Transproc::HashTransformations
    extend ::Transproc::ArrayTransformations

    uses :is,        from: ::Transproc::Conditional
    uses :recursion, from: ::Transproc::Recursion

    # Returns either value or default value if value is of improper type
    #
    # @example
    #   fn = Faceter::Transproc[:maybe, :Hash, {}]
    #   fn[{ foo: :FOO }] # => { foo: :FOO }
    #   fn[:FOO]          # => {}
    #
    # @param [Object] value
    # @param [Class] type
    # @param [Object] default
    #
    # @return [value, default]
    #
    def maybe(value, type, default)
      value.instance_of?(type) ? value : default
    end

    # Returns a new hash where given keys removed if they contain empty values
    #
    # @example
    #   fn = Faceter::Transproc[:clear_tuples, :foo]
    #   fn[{ foo: {}, bar: {} }]            # => { bar: {} }
    #   fn[{ foo: { baz: :BAZ }, bar: {} }] # => { foo: { baz: :BAZ }, bar: {} }
    #
    # @param [Hash] hash
    # @param [Array] keys
    #
    # @return [Hash]
    #
    def clear_tuples(hash, keys)
      hash.reject { |key, value| keys.include?(key) && value.empty? }
    end

    # Splits hash into two hashes, first of which contains given keys,
    # the second one contains the rest of the hash
    #
    # @example
    #   fn = Faceter::Transproc[:split_hash, [:foo]]
    #   fn[{ foo: :FOO, bar: :BAR }]
    #   # => [{ foo: :FOO }, { bar: :BAR }]
    #
    # @param [Hash] hash
    # @param [Array] keys
    #
    # @return [[Hash, Hash]]
    #
    def split_hash(hash, keys)
      [accept_keys(hash, keys), reject_keys(hash, keys)]
    end

    # Wraps the object to the hash with given key
    #
    # If additional keys given, then the object is treated as an existing hash.
    # The function adds a new key to it and begirds given keys only.
    #
    # @overload begird(value, key)
    #   Wraps value to the hash under the key
    #
    #   @example
    #     source = :FOO
    #
    #     fn = Faceter::Transproc[:begird, :foo]
    #     fn[source] # => { foo: :FOO }
    #
    #   @param [Object] value
    #   @param [Object] key
    #
    #   @return [Hash]
    #
    # @overload begird(value, key, keys)
    #   Wraps selected keys to the subhash under the key
    #
    #   @example Wraps values to given key
    #     source = { foo: :FOO, bar: :BAR, baz: :BAZ }
    #
    #     fn = Faceter::Transproc[:begird, :foo, [:bar, :baz]]
    #     fn[source] # => { foo: { bar: :BAR, baz: :BAZ } }
    #
    #     fn = Faceter::Transproc[:begird, :foo, [:bar]]
    #     fn[source] # => { foo: { bar: :BAR }, baz: :BAZ }
    #
    #   @example Wraps values to existing subhash
    #     source = { foo: { bar: :BAR }, baz: :BAZ }
    #
    #     fn = Faceter::Transproc[:begird, :foo, [:baz]]
    #     fn[source] # => { foo: { bar: :BAR, baz: :BAZ } }
    #
    #   @param [Hash] value
    #   @param [Object] name
    #   @param [Array] keys
    #
    #   @return [Hash]
    #
    def begird(value, name, keys = [])
      return Hash[name, value] if keys.empty?

      wrapped, unwrapped = t(:split_hash, keys)[value]
      subhash = t(:maybe, Hash, {})[unwrapped[name]]

      unwrapped.merge(name => subhash.merge(wrapped))
    end

    # Ungirds the hash by values from given field
    #
    # @overload ungird(hash, name)
    #   Returns the hash value by the field name
    #
    #   @example
    #     source = { foo: :FOO, bar: :BAR }
    #
    #     fn = Faceter::Transproc[:ungird, :foo]
    #     fn[source] # => :FOO
    #
    #   @param [Hash] hash
    #   @param [Object] name
    #
    #   @return [Hash]
    #
    # @overload ungird(hash, name, keys)
    #   Unwraps values under the field name and merges them to the source hash
    #
    #   @example
    #     source = { foo: { bar: :BAR, baz: :BAZ } }
    #
    #     fn = Faceter::Transproc[:ungird, :foo, [:bar, :baz]]
    #     fn[source] # => { bar: :BAR, baz: :BAZ }
    #
    #     fn = Faceter::Transproc[:ungird, :foo, [:baz]]
    #     fn[source] # => { foo: { bar: :BAR }, baz: :BAZ }
    #
    #   @param [Hash] hash
    #   @param [Object] name
    #   @param [Array] keys
    #
    #   @return [Hash]
    #
    def ungird(hash, name, keys = [])
      value = hash[name]
      return value if keys.empty?

      extracted, untouched = t(:split_hash, keys)[value]
      output = hash.merge(extracted).merge(name => untouched)

      t(:clear_tuples, [name])[output]
    end

    # Applies the function to the source and converts the result to symbol
    # if the source data was a symbol. Otherwise returns a string.
    #
    # @param [String, Symbol] source
    # @param [::Transproc::Function] fn
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
    #   fn = Faceter::Transproc[:add_prefix, "foo", "."]
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
    #   fn = Faceter::Transproc[:drop_prefix, "foo", "."]
    #   fn["foo.bar"]  # => "bar"
    #
    # @param [String, Symbol] name
    # @param [String, Symbol] prefix
    # @param [String, Symbol] separator
    #
    # @return [String]
    #
    def drop_prefix(name, prefix, separator)
      name.to_s.sub(/^#{prefix}#{separator}/, "")
    end

    # @overload apply(value, &block)
    #   Applies the block to the object
    #
    #   @param [Object] value
    #   @param [Proc] block
    #
    # @overload apply(value, keys, &block)
    #   Applies the block to the hash values from given keys
    #
    #   @param [Hash] value
    #   @param [Proc] block
    #   @param [Array] keys
    #
    # @return [Object] the result
    #
    def apply(value, block, keys = [])
      values = keys.any? ? value.values_at(*keys) : value
      block.call(values)
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
    #   fn = Faceter::Transproc[:merge, :foo, proc]
    #   fn[source] # => { foo: :BAZ }
    #
    #   fn = Faceter::Transproc[:merge, :bar, proc]
    #   fn[source] # => { foo: :FOO, bar: :BAZ }
    #
    #   fn = Faceter::Transproc[:merge, nil, proc]
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

    # Breaks array into hash where each key is a value from array
    # referred to consecutive values that are equal to it
    # (but not necessarily identical).
    #
    # @example
    #   source = [1, 1.0, 1, 2, 2, 1.0, 1]
    #   Faceter::Transproc[:classify][source]
    #   # => { 1 => [1.0, 1], 2 => [2], 1.0 => [1] }
    #
    # @param [Array] array
    #
    # @return [Hash<Object => Array>]
    #
    def classify(array)
      list = array.each_with_object([]) do |item, arr|
        last = arr.last
        (last && (last.first == item)) ? (last.last << item) : (arr << [item, []])
      end

      Hash[list]
    end

    # Applies given transformation to the hash
    #
    # If a second argument is set to true, does it recursively for
    # nested levels of data
    #
    # @param [Object] data
    # @param [Boolean] nested
    # @param [::Transproc::Function] fn
    #
    # @return [Object] transformed data
    #
    def apply_to_hash(data, nested, fn)
      ops = t(:is, Hash, fn)
      ops = t(:recursion, ops) if nested
      ops[data]
    end

    # Returns a new string in camel-case
    #
    # @example
    #   fn = Faceter::Transproc[:camelize]
    #   fn["foo_bar"] # => "FooBar"
    #
    # @param [String] value
    #
    # @return [String]
    #
    def camelize(value)
      Inflecto.camelize(value)
      # value.split(/_+/).map(&:capitalize).join
    end

    # Returns a constant by name defined in given namespace
    #
    # @example
    #   fn = Faceter::Transproc[:constantize]
    #   fn["String"] # => ::String
    #
    #   fn = Faceter::Transproc[:constantize, MyModule]
    #   fn["String"] # => ::MyModule::String
    #
    # @param [String, Symbol] name
    #
    # @return [Constant]
    #
    def constantize(name, namespace = self)
      namespace.const_get name
    end

  end # module Transproc

end # module Faceter
