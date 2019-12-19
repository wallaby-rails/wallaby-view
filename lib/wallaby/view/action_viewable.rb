# frozen_string_literal: true

module Wallaby
  module View
    # This is a collection of the helper methods that overrides the rails methods
    module ActionViewable
      # Overrid {}
      def view_renderer
        @_view_renderer ||= # rubocop:disable Naming/MemoizedInstanceVariableName
          CustomRenderer.new(lookup_context)
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
      def _prefixes(
        prefixes: nil,
        action_name: nil,
        theme_name: nil,
        options: {}, &block
      )
        @_prefixes ||= CustomPrefixes.build(
          prefixes: prefixes || super(),
          action_name: action_name || params[:action] || self.action_name,
          theme_name: theme_name || current_theme_name,
          options: options, &block
        )
      end
    end
  end
end
