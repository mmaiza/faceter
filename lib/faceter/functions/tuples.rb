# encoding: utf-8

require "transproc/hash"

module Faceter

  module Functions

    # Transformations of tuples (hashes)
    #
    module Tuples

      extend Transproc::Registry

      uses :accept_keys, from: Transproc::HashTransformations
      uses :reject_keys, from: Transproc::HashTransformations
      uses :reverse,     from: Options

      # Returns a subhash with keys, defined by options
      #
      # @example
      #   source = { foo: :FOO, bar: :BAR }
      #
      #   fn = Tuples[:subhash]
      #   fn[source] # => { foo: :FOO, bar: :BAR }
      #
      #   fn = Tuples[:subhash, only: [:foo]]
      #   fn[source] # => { foo: :FOO }
      #
      #   fn = Tuples[:subhash, except: [:foo]]
      #   fn[source] # => { bar: :BAR }
      #
      # @param [Hash] hash
      # @param (see Faceter::Functions::Options#reverse)
      #
      # @return [Hash]
      #
      def sub(hash, options = {})
        whitelist = options.fetch(:only, nil)
        blacklist = options.fetch(:except, nil)

        return accept_keys(hash, Array[*whitelist]) if whitelist
        reject_keys(hash, Array[*blacklist])
      end

      # Splits the hash into two parts, where the first one is defined
      # by options, while the second contains the rest of the source
      #
      # @example
      #   source = { foo: :FOO, bar: :BAR, baz: :BAZ }
      #   fn = Tuples[:split, except: :bar]
      #   fn[source] => [{ foo: :FOO, baz: :BAZ }, { bar: :BAR }]
      #
      # @param [Hash] hash
      # @param (see Faceter::Functions::Options#reverse)
      #
      # @return [Array<Hash>]
      #
      def split(hash, options = {})
        return [hash, {}] if options.empty?
        [sub(hash, options), sub(hash, reverse(options))]
      end

      # Removes selected keys from hash if they values are empty
      #
      # @example
      #   fn = Tuples[:clean, [:foo, :bar]]
      #   fn[foo: { foo: :FOO }, bar: {}, baz: {}]
      #   # => { foo: { foo: :FOO }, baz: {} }
      #
      # @param [Hash] hash
      # @param [Array] keys
      #
      # @return [Hash]
      #
      def clean(hash, *keys)
        names = keys.flatten
        hash.reject { |key, value| names.include?(key) && value.empty? }
      end

      # Partially unwraps a subhash under the hash key following the options
      #
      # @example
      #   fn = Tuples[:unwrap, :foo, only: :bar]
      #   fn[foo: { bar: :BAR, baz: :BAZ }, qux: :QUX]
      #   # => { qux: :QUX, foo: { baz: :BAZ }, bar: :BAR }
      #
      # @param [Hash] hash
      # @param [Object] key
      # @param (see Faceter::Functions::Options#reverse)
      #
      # @return Hash
      #
      def unwrap(hash, key, options = {})
        extracted, keep = split hash.fetch(key, {}), options
        lean_hash = clean hash.merge(key => keep), key
        lean_hash.merge(extracted)
      end

      # Partially wraps a subhash into the new key following the options
      #
      # @example
      #   fn = Tuples[:wrap, :foo, only: :bar]
      #   fn[foo: { baz: :BAZ }, bar: :BAR, qux: :QUX]
      #   # => { foo: { baz: :BAZ, bar: :BAR }, qux: :QUX }
      #
      # @param [Hash] hash
      # @param [Object] key
      # @param (see Faceter::Functions::Options#reverse)
      #
      # @return Hash
      #
      def wrap(hash, key, options = {})
        to_wrap, to_keep = split hash, options
        wrapped = to_keep[key]

        to_wrap = wrapped.merge(to_wrap) if wrapped.instance_of? Hash
        to_keep.merge(key => to_wrap)
      end

    end # module Tuples

  end # module Functions

end # module Faceter
