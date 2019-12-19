# frozen_string_literal: true

module Wallaby
  module View
    # A custom lookup context that uses {Wallaby::CustomResolver} to find cell/partial
    class CustomLookupContext < ::ActionView::LookupContext
      # @param lookup_context [ActionView::LookupContext]
      # @param details [Hash]
      # @param prefixes [Array]
      def self.convert(lookup_context, details: nil, prefixes: nil)
        return lookup_context if lookup_context.is_a? self

        new(
          lookup_context.view_paths,
          details || lookup_context.instance_variable_get('@details'),
          prefixes || lookup_context.prefixes
        )
      end

      # @note for Rails version 6 and above
      # It overrides the origin method to convert paths to {Wallaby::CustomResolver}
      # @param paths [Array]
      # @return [ActionView::PathSet]
      def build_view_paths(paths)
        CustomPathSet.new Array(paths)
      end

      # @note for Rails version below 6
      # It overrides the origin method to convert paths to {Wallaby::CustomResolver}
      # @param paths [Array]
      # @return [ActionView::PathSet]
      def view_paths=(paths)
        @view_paths = build_view_paths paths
      end

      # It overrides the oirgin method to call the origin `find_template` and cache the result during a request.
      # @param name [String]
      # @param prefixes [Array<String>]
      # @param partial [Boolean]
      # @param keys [Array<String>] keys of local variables
      # @param options [Hash]
      def find_template(name, prefixes = [], partial = false, keys = [], options = {})
        cache_key = [name, prefixes, partial].map(&:inspect).join(SLASH)
        cached_lookup[cache_key] ||= super
      end

      protected

      # @!attribute [r] cached_lookup
      # Cached lookup result
      def cached_lookup
        @cached_lookup ||= {}
      end
    end
  end
end
