module Collections
  class CellArrayCellPartialEachHtml < ApplicationTemplate
    def to_template
      1000.times.each do
        concat render partial: 'cell_partial'
      end
    end
  end
end
