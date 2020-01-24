module Errors
  class UnknownHtml < ApplicationTemplate
    def to_template
      raise 'unknown error'
    end
  end
end
