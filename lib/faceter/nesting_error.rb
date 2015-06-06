# encoding: utf-8

# The exception to be raised when a useless branch is added to AST
#
class Faceter::NestingError < RuntimeError

  # @private
  def initialize
    super "useless nesting without transformations"
  end

end # class Faceter::NestingError
