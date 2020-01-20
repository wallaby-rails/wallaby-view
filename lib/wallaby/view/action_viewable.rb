# frozen_string_literal: true

module Wallaby
  module View
    # This module overrides Rails core methods `lookup_context` and `prefixes`
    # to provide support for {Wallaby::Cell} lookup and rendering.
    module ActionViewable
      extend ActiveSupport::Concern

      class_methods do
        # @!attribute [w] prefix_options
        attr_writer :prefix_options

        # @!attribute [r] prefix_options
        # It stores the options for {#prefixes}
        # @return [Hash] prefix options
        def prefix_options
          @prefix_options ||=
            superclass.respond_to?(:prefix_options) && superclass.prefix_options || nil
        end
      end

      # Override {https://github.com/rails/rails/blob/master/actionview/lib/action_view/view_paths.rb
      # ActionView::ViewPaths::ClassMethods#_prefixes} to extend the
      # @return {Wallaby::View::CustomLookupContext}
      def lookup_context
        @_lookup_context ||= # rubocop:disable Naming/MemoizedInstanceVariableName
          CustomLookupContext.convert(
            super, prefixes: _prefixes
          )
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
        options: nil, &block
      )
        @_prefixes ||= CustomPrefixes.build(
          prefixes: prefixes || super(),
          action_name: action_name || params[:action] || self.action_name,
          theme_name: theme_name || self.class.theme_name,
          options: options || self.class.prefix_options, &block
        )
      end
    end
  end
end
