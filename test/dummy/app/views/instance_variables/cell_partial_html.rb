module InstanceVariables
  class CellPartialHtml < ApplicationPartial
    def to_partial
      content_tag(:h2, @h1)
    end
  end
end
