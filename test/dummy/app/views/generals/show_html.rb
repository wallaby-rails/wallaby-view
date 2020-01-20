module Generals
  class ShowHtml < ApplicationTemplate
    def file
      __FILE__
    end

    def to_template
      concat content_tag(:h1, to_render)
      concat content_tag(:h2, render('title'))
      content_tag(:h3, render('description'))
    end
  end
end
