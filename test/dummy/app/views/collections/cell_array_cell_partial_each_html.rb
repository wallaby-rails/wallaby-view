module Collections
  class CellArrayCellPartialEachHtml < ApplicationTemplate
    def to_template
      100.times.each do
        concat render partial: 'cell_partial'
      end
    end
  end
end
