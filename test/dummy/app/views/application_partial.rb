class ApplicationPartial < Wallaby::Cell
  def file
    __FILE__
  end

  def to_render
    file[/#{controller_name}.+/]
  end

  def to_partial
    content_tag :h2, to_render
  end
end