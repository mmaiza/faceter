# encoding: utf-8

# The exception to be raised when a useless branch is added to AST
#
class Faceter::Error < RuntimeError

  # @private
  def initialize(branch)
    super "The node #{branch.inspect} is worthless"
  end

end # class Faceter::Error
