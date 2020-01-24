module Layouts
  class ThemeOneHtml < Wallaby::Cell
    def to_render
      content_tag(:html) do
        concat content_tag(:head, content_tag(:title, 'theme_one'))
        concat content_tag(:body, yield)
      end
    end
  end
end
