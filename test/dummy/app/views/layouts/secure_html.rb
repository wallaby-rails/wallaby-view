module Layouts
  class SecureHtml < Wallaby::Cell
    def to_render
      content_tag(:html) do
        concat content_tag(:head, content_tag(:title, 'secure'))
        concat content_tag(:body, yield)
      end
    end
  end
end
