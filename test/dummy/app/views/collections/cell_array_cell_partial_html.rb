module Collections
  class CellArrayCellPartialHtml < ApplicationTemplate
    def to_template
      concat render partial: 'cell_partial', collection: 1..1000
    end
  end
end
