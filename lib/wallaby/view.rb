# frozen_string_literal: true

require 'wallaby/view/railtie'
require 'wallaby/view/themeable'
require 'wallaby/view/action_viewable'

require 'concerns/wallaby/shared_helpers'
require 'concerns/wallaby/resourcable'

require 'services/wallaby/prefixes_builder'

require 'renderers/wallaby/cell'
require 'renderers/wallaby/view/custom_lookup_context'
require 'renderers/wallaby/view/custom_partial_renderer'
require 'renderers/wallaby/view/custom_path_set'
require 'renderers/wallaby/view/custom_renderer'
require 'renderers/wallaby/view/custom_resolver'

require 'utils/wallaby/cell_utils'
require 'utils/wallaby/module_utils'

module Wallaby
  # To extend Rails layout and rendering
  module View
    extend ActiveSupport::Concern

    COLONS = '::'
    COLON = ':'
    COMMA = ','
    RB = 'rb'
    EMPTY_STRING = ''
    SLASH = '/'
    FORM_ACTIONS = { new: 'form', create: 'form', edit: 'form', update: 'form' }.with_indifferent_access.freeze

    include ActionViewable
    include Themeable

    included do
      # NOTE: for controller only
      helper_method :view_renderer if self < ::ActionController::Base
    end
  end
end

