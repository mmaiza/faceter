# encoding: utf-8

module Faceter

  module Functions

    # Transformations of options (:except and :only)
    #
    module Options

      extend Transproc::Registry

      # Reverses black and white lists
      #
      # @example
      #   fn = Options[:reverse]
      #   fn[blacklist: :foo, whitelist: :bar] # => { blacklist: :bar }
      #   fn[blacklist: :foo]                  # => { whitelist: :foo }
      #   fn[]                                 # => { blacklist: []   }
      #
      # @param [Hash] options ({})
      # @option options [Object, Array<Object>] :only
      #   The whitelist of keys to be taken from a hash
      # @option options [Object, Array<Object>] :except
      #   The blacklist of keys not to be taken from a hash
      #
      # @return [Hash]
      #
      def reverse(options = {})
        whitelist = options[:only]
        blacklist = options[:except]

        return { except: whitelist } if whitelist
        return { only: blacklist }   if blacklist
        { except: [] }
      end

      # Checks if a key satisfies restrictions that are set by options
      #
      # @example
      #   fn = Options[:check, only: [:foo, :bar]]
      #   fn[:foo]  # => true
      #   fn["foo"] # => false
      #
      # @param [Object] key The key to be checket agaist the options
      # @param (see #reverse)
      #
      # @return [Boolean]
      #
      def check(key, options = {})
        whitelist = options[:only]
        blacklist = options[:except]

        return Array[*whitelist].include?(key) if whitelist
        !Array[*blacklist].include?(key)
      end

    end # module Options

  end # module Functions

end # module Faceter
