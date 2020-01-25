module Collections
  class CellPartialHtml < ApplicationPartial
    def to_render
      SecureRandom.uuid
    end
  end
end
