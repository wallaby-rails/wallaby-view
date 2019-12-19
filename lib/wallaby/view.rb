# frozen_string_literal: true

require 'wallaby/view/railtie'
require 'wallaby/view/themeable'

require 'wallaby/cell'
require 'wallaby/view/action_viewable'
require 'wallaby/view/custom_lookup_context'
require 'wallaby/view/custom_partial_renderer'
require 'wallaby/view/custom_path_set'
require 'wallaby/view/custom_prefixes'
require 'wallaby/view/custom_renderer'
require 'wallaby/view/custom_resolver'

module Wallaby
  # To extend Rails layout and rendering
  module View
    extend ActiveSupport::Concern

    DOT = '.'
    COMMA = ','
    RB = 'rb'
    EMPTY_STRING = ''
    SLASH = '/'

    include ActionViewable
    include Themeable

    included do
      # NOTE: for controller only
      helper_method :view_renderer if self < ::ActionController::Base
    end
  end
end
