# frozen_string_literal: true

require 'wallaby/view/railtie'
require 'wallaby/view/action_viewable'
require 'wallaby/view/themeable'

require 'wallaby/cell'
require 'wallaby/view/custom_lookup_context'
require 'wallaby/view/custom_path_set'
require 'wallaby/view/custom_prefixes'
require 'wallaby/view/custom_resolver'
require 'wallaby/view/custom_template'

module Wallaby
  # To extend Rails layout and rendering
  module View
    extend ActiveSupport::Concern

    COMMA = ','
    EMPTY_STRING = ''
    DOT_RB = '.rb'
    SLASH = '/'

    include ActionViewable
    include Themeable
  end
end
