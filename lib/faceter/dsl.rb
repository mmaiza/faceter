# encoding: utf-8

module Faceter

  # The container for specific branches to browse a data,
  # and nodes to transform them
  #
  module DSL

    # Autoloads all the content from "faceter/dsl/*" with DSL-specific classes
    Dir[File.expand_path("../dsl/*.rb", __FILE__)].each(&method(:require))

    # List of DSL commands pointing to a specific class to be added to AST
    #
    # @return [Hash<Symbol => Class>]
    #
    COMMANDS = {
      add_prefix:     AddPrefix,
      create:         Create,
      exclude:        Exclude,
      field:          Field,
      fold:           Fold,
      group:          Group,
      list:           List,
      remove_prefix:  RemovePrefix,
      rename:         Rename,
      stringify_keys: StringifyKeys,
      symbolize_keys: SymbolizeKeys,
      unfold:         Unfold,
      ungroup:        Ungroup,
      unwrap:         Unwrap,
      wrap:           Wrap
    }

    # Checks whether the DSL command is defined
    #
    # @param [Symbol] name
    #
    # @return [Boolean]
    #
    def self.defines?(name)
      nil ^ COMMANDS[name]
    end

  end # module DSL

end # module Faceter
