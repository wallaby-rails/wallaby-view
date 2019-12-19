# frozen_string_literal: true

module Wallaby
  module View
    # This is a collection of the helper methods that overrides the rails methods
    module ActionViewable
      # Overrid {}
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
end
