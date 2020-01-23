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

    # Rename the methods so that:
    #
    # 1. It's possible to access the original methods:
    #
    #     - {https://github.com/rails/rails/blob/master/actionview/lib/action_view/view_paths.rb#L97 lookup_context}
    #       (now becomes {Wallaby::View::ActionViewable#original_lookup_context original_lookup_context})
    #     - {https://github.com/rails/rails/blob/master/actionview/lib/action_view/view_paths.rb#L90 _prefixes}
    #       (now becomes {Wallaby::View::ActionViewable#original_prefixes original_prefixes})
    #
    # 2. Override the original methods:
    #
    #     - {Wallaby::View::ActionViewable#override_lookup_context override_lookup_context}
    #       (now becomes `lookup_context`)
    #     - {Wallaby::View::ActionViewable#override_prefixes override_prefixes}
    #       (now becomes `_prefixes`)
    # @param mod [Module]
    def self.included(mod)
      mod.alias_method :original_lookup_context, :lookup_context
      mod.alias_method :original_prefixes, :_prefixes
      mod.alias_method :lookup_context, :override_lookup_context
      mod.alias_method :_prefixes, :override_prefixes
    end

    COMMA = ','
    EMPTY_STRING = ''
    DOT_RB = '.rb'
    SLASH = '/'

    include ActionViewable
    include Themeable
  end
end
