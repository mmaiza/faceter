# encoding: utf-8

module Faceter

  # The IoC for specific branches to browse a data, and nodes to transform them.
  #
  # @todo The module with all its content is ready for decoupling
  #   from a faceter to a separate gem `faceter-rom`. The whole idea is
  #   that `faceter` to store mapper AST only.
  #
  #   Then various mappers (like a mapper for ROM, or mapper for
  #   sorting out the content of file load) will define their own DSL nodes
  #   along with DSL-specific optimization rules.
  #
  module DSL

    # Provides access to set a DSL for the abstract syntax tree
    #
    # @example
    #   Faceter::DSL.setup do
    #     command :create, DSL::Create
    #   end
    #
    def self.setup(&block)
      instance_eval(&block)
    end

    # List of DSL commands pointing to a specific class to be added to AST
    #
    # @return [Hash<Symbol => Class>]
    #
    def self.commands
      @commands ||= {}
    end

    # Registers the DSL command
    #
    # @param [#to_sym] name
    #   The name of the command
    # @param [Class] :node
    #   The specific node type to implement the command in the AST
    #
    # @return [undefined]
    #
    def self.command(name, node)
      commands[name.to_sym] = node
    end

    # Checks whether the DSL command with given name is defined
    #
    # @param [Symbol] name
    #
    # @return [Boolean]
    #
    def self.command?(name)
      nil ^ commands[name]
    end

  end # module DSL

end # module Faceter

# Autoloads all the content from "faceter/dsl/*" with DSL-specific classes
# @todo: extract to the separate `faceter`-based gem
#
Dir[File.expand_path("../dsl/*.rb", __FILE__)].each(&method(:require))

# Declares DSL-specific commands
Faceter::DSL.setup do
  command :add_prefix,     Faceter::DSL::AddPrefix
  command :create,         Faceter::DSL::Create
  command :exclude,        Faceter::DSL::Exclude
  command :field,          Faceter::DSL::Field
  command :fold,           Faceter::DSL::Fold
  command :group,          Faceter::DSL::Group
  command :list,           Faceter::DSL::List
  command :remove_prefix,  Faceter::DSL::RemovePrefix
  command :rename,         Faceter::DSL::Rename
  command :stringify_keys, Faceter::DSL::StringifyKeys
  command :symbolize_keys, Faceter::DSL::SymbolizeKeys
  command :unfold,         Faceter::DSL::Unfold
  command :ungroup,        Faceter::DSL::Ungroup
  command :unwrap,         Faceter::DSL::Unwrap
  command :wrap,           Faceter::DSL::Wrap
end
