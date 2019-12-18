# frozen_string_literal: true

module Wallaby
  # To extend Rails layout and rendering
  module View
    extend ActiveSupport::Concern

    included do
      helper_method :view_renderer if self < ActionController::Base
    end

    #
    def view_renderer
      @_view_renderer ||= CustomRenderer.new(lookup_context)
    end

    # Override {https://github.com/rails/rails/blob/master/actionview/lib/action_view/view_paths.rb
    # ActionView::ViewPaths::ClassMethods#_prefixes} to extend the prefixes for **ActionView::ViewPaths** to look up
    # in below precedence from high to low:
    #
    # - :mounted_path/:resources_name/:action_prefix (e.g. `admin/products/index`)
    # - :mounted_path/:resources_name (e.g. `admin/products`)
    # - :controller_path/:action_prefix
    # - :controller_path
    # - :parent_controller_path/:action_prefix
    # - :parent_controller_path
    # - :more_parent_controller_path/:action_prefix
    # - :more_parent_controller_path
    # - :theme_name/:action_prefix
    # - :theme_name
    # - wallaby/resources/:action_prefix
    # - wallaby/resources
    # @return [Array<String>]
    def _prefixes
      @_prefixes ||= PrefixesBuilder.build(
        origin_prefixes: super,
        theme_name: current_theme_name,
        resources_name: current_resources_name,
        script_name: request.env['SCRIPT_NAME'],
        action_name: params[:action]
      )
    end
  end
end

require 'wallaby/view/railtie'
require 'wallaby/constants'

require 'concerns/wallaby/rails_overridden_methods'
# require 'concerns/wallaby/engineable'
require 'concerns/wallaby/themeable'
require 'concerns/wallaby/shared_helpers'
require 'concerns/wallaby/resourcable'

require 'errors/wallaby/cell_handling'

require 'services/wallaby/prefixes_builder'

require 'renderers/wallaby/cell'
require 'renderers/wallaby/cell_resolver'
require 'renderers/wallaby/custom_lookup_context'
require 'renderers/wallaby/custom_renderer'
require 'renderers/wallaby/custom_partial_renderer'

require 'utils/wallaby/cell_utils'
require 'utils/wallaby/module_utils'
