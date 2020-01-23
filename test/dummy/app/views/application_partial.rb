class ApplicationPartial < Wallaby::Cell
  def file
    __FILE__
  end

  def to_render
    file[(file.index('app/views/') + 10)..-1]
  end

  def to_partial
    content_tag :h2, to_render
  end
end
