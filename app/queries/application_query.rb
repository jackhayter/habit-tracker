# frozen_string_literal: true

# Superclass for query objects in the application
#
class ApplicationQuery
  class << self
    delegate :call, to: :new
  end
end
