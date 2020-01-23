module Formats
  class CellTemplateCellPartialWithoutHtmlSuffixJson < ApplicationTemplate
    def file
      __FILE__
    end

    def to_template
      { something: :else }.to_json.html_safe
    end
  end
end
