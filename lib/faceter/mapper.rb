# encoding: utf-8

module Faceter

  # The base class for mappers
  #
  # @example
  #   class MyMapper < Faceter::Mapper
  #     group :id, :name, :email, to: :user
  #
  #     field :user do
  #       group :email, to: contacts
  #
  #       field :contacts
  #         unwrap :email
  #       end
  #     end
  #   end
  #
  #   source = [
  #     { name: "joe",  email: "joe@doe.com", role: "admin" },
  #     { name: "joe",  email: "joe@doe.org", role: "admin" },
  #     { name: "jane", email: "jane@doe.com", role: "admin" },
  #   ]
  #
  #   mapper = MyMapper.new
  #   mapper.call(source)
  #   # => [
  #   #      {
  #   #        role: "admin",
  #   #        users:[
  #   #          { name: "joe", contacts: ["joe@doe.com", "joe@doe.org"] },
  #   #          { name: "jane", contacts: ["jane@doe.com"] }
  #   #        ]
  #   #      }
  #   #    ]
  #
  # @api public
  #
  class Mapper

    # @private
    class << self

      # The builder of AST
      #
      # @return [Transproc::Function]
      #
      def builder
        @builder ||= Builder.new
      end

      private

      # Allows builder's DSL methods to be called from a class scope
      #
      # @private
      #
      def method_missing(name, *args, &block)
        super unless respond_to? name
        @builder = Builder.new(builder.tree) do
          __send__(name, *args, &block)
        end
      end

      def respond_to_missing?(name, *)
        DSL.command?(name)
      end

    end # eigenclass

    # @!scope class
    # @!method new
    # Creates an instance that wraps a transproc from the optimized AST
    #
    # @example
    #   mapper = Faceter.new
    #
    # @return [Faceter]
    #
    def initialize
      @tree = Optimizer[self.class.builder.tree]
      @transproc = @tree.transproc
      freeze
    end

    # Transforms the data

    #
    # @param [Object] data
    #
    # @return [Object]
    #
    def call(data)
      @transproc.call(data)
    end

  end # class Mapper

end # module Faceter
