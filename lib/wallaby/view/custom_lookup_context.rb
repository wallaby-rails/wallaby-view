# frozen_string_literal: true

module Wallaby
  module View
    # The custom lookup context uses
    # {Wallaby::View::CustomResolver} to find cell/partial.
    class CustomLookupContext < ::ActionView::LookupContext
      # @param lookup_context [ActionView::LookupContext]
      # @param details [Hash]
      # @param prefixes [Array]
      # @return [Wallaby::View::CustomLookupContext]
      def self.convert(lookup_context, details: nil, prefixes: nil)
        return lookup_context if lookup_context.is_a? self

        new(
          lookup_context.view_paths,
          details || lookup_context.instance_variable_get('@details'),
          prefixes || lookup_context.prefixes
        )
      end

      # @note for Rails version 6 and above
      # It overrides the origin method
      # to convert paths to {Wallaby::View::CustomPathSet}
      # @param paths [Array]
      # @return [Wallaby::View::CustomPathSet]
      def build_view_paths(paths)
        CustomPathSet.new Array(paths)
      end

      # @note for Rails version below 6
      # It overrides the origin method
      # to store and convert paths to {Wallaby::View::CustomPathSet}
      # @param paths [Array]
      # @return [Wallaby::View::CustomPathSet]
      def view_paths=(paths)
        @view_paths = build_view_paths paths
      end
    end
  end
end
