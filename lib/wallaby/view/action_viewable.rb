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

      # @!method original_lookup_context
      #   Alias method for the original
      #   {https://github.com/rails/rails/blob/master/actionview/lib/action_view/view_paths.rb#L97 lookup_context}
      #   @return [ActionView::LookupContext]

      # @!method original_prefixes
      #   Alias method for the original
      #   {https://github.com/rails/rails/blob/master/actionview/lib/action_view/view_paths.rb#L90 _prefixes}
      #   @return [Array<String>]

      # Override
      # {https://github.com/rails/rails/blob/master/actionview/lib/action_view/view_paths.rb#L97 lookup_context}
      # to extend the functionality so that {Wallaby::Cell} file can be discovered.
      # @return {Wallaby::View::CustomLookupContext}
      def override_lookup_context
        @_lookup_context ||= # rubocop:disable Naming/MemoizedInstanceVariableName
          CustomLookupContext.convert(original_lookup_context, prefixes: _prefixes)
      end

      # TODO: need to think about how to make this extensible.
      #
      # Override {https://github.com/rails/rails/blob/master/actionview/lib/action_view/view_paths.rb#L90 _prefixes}
      # to allow other prefixes (e.g. `action_name`, `theme_name`) to be added to the prefixes list:
      # @param prefixes [Array<String>] the base prefixes
      # @param action_name [String] the action name to add to the prefixes list
      # @param theme_name [String] the theme name to add to the prefixes list
      # @param options [Hash] the options for {Wallaby::View::CustomPrefixes}
      # @return [Array<String>]
      def override_prefixes(
        prefixes: nil,
        action_name: nil,
        theme_name: nil,
        options: nil, &block
      )
        @_prefixes ||= CustomPrefixes.build( # rubocop:disable Naming/MemoizedInstanceVariableName
          prefixes: prefixes || original_prefixes,
          action_name: action_name || params[:action] || self.action_name,
          theme_name: theme_name || self.class.theme_name,
          options: options || self.class.prefix_options, &block
        )
      end
    end
  end
end
