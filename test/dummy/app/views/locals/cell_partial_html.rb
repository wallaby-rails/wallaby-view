module Locals
  class CellPartialHtml < ApplicationPartial
    def to_partial
      content_tag(:h2, h2)
    end
  end
end
