# encoding: utf-8

require "transproc/conditional"

module Faceter

  # Collection of the gem-specific transproc pure functions
  #
  # @example
  #   fn = Functions[:add_prefix, "foo", "_"]
  #   fn["baz"] # => "foo_baz"
  #
  #   Functions.add_prefix("baz", "foo", "_")
  #   # => "foo_baz"
  #
  # @api private
  #
  module Functions

    require_relative "functions/options"
    require_relative "functions/arrays"
    require_relative "functions/conditionals"
    require_relative "functions/keys"
    require_relative "functions/tuples"

    extend Transproc::Registry

    uses :accept_keys,    from: Transproc::HashTransformations
    uses :add_prefix,     from: Keys
    uses :apply_to_hash,  from: Conditionals
    uses :check,          from: Options
    uses :claster,        from: Arrays
    uses :drop_prefix,    from: Keys
    uses :execute,        from: Conditionals
    uses :group,          from: Transproc::ArrayTransformations
    uses :guard,          from: Transproc::Conditional
    uses :itself,         from: Conditionals
    uses :keep_symbol,    from: Keys
    uses :map_array,      from: Transproc::ArrayTransformations
    uses :map_keys,       from: Transproc::HashTransformations
    uses :map_value,      from: Transproc::HashTransformations
    uses :merge,          from: Conditionals
    uses :reject_keys,    from: Transproc::HashTransformations
    uses :rename_keys,    from: Transproc::HashTransformations
    uses :stringify_keys, from: Transproc::HashTransformations
    uses :symbolize_keys, from: Transproc::HashTransformations
    uses :ungroup,        from: Transproc::ArrayTransformations
    uses :unwrap,         from: Tuples
    uses :wrap,           from: Tuples

  end # module Functions

end # module Faceter
