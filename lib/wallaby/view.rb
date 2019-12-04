# frozen_string_literal: true

module Wallaby
  # To extend Rails layout and rendering
  module View
  end
end

require 'wallaby/view/railtie'

require 'renderers/wallaby/cell'
require 'renderers/wallaby/cell_resolver'
require 'renderers/wallaby/custom_lookup_context'
require 'renderers/wallaby/custom_renderer'
require 'renderers/wallaby/custom_partial_renderer'
