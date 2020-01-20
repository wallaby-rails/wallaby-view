module Layouts
  class PrecedenceHtml < Wallaby::Cell
    def to_template
      content_tag(:html) do
        concat content_tag(:head, content_tag(:title, 'cell layout'))
        concat content_tag(:body, yield)
      end
    end
  end
end
