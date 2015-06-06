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
  class Mapper < SimpleDelegator

    # @private
    class << self

      # The current state of transproc, provided by the builder-carried AST
      #
      # @return [::Transproc::Function]
      #
      def transproc
        tree.transproc
      end

      private

      # The object that carries the AST and adds new branches to it using DSL
      #
      # @return [Builder]
      #
      # @api private
      #
      def builder
        @builder ||= Builder.new
      end

      # The optimized AST having been built and carried by the builder
      #
      # @return [Faceter::AST::Root]
      #
      def tree
        builder.finalize
      end

      # Allows builder DSL method to be called from a class scope
      # as if they were the class methods
      #
      # @private
      def method_missing(*args, &block)
        builder.public_send(*args, &block)
      end

      def respond_to_missing?(*args)
        builder.respond_to?(*args)
      end

    end # eigenclass

    # @!scope class
    # @!method new
    # Creates an instance that wraps a transproc from the current state of AST
    #
    # @example
    #   mapper = Faceter.new
    #
    # @return [Faceter]
    #
    def self.new
      super(transproc).freeze
    end

  end # class Mapper

end # module Faceter
