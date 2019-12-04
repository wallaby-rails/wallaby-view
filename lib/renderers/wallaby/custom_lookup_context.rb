# frozen_string_literal: true

module Wallaby
  # A custom lookup context that uses {Wallaby::CellResolver} to find cell/partial
  class CustomLookupContext < ::ActionView::LookupContext
    def self.normalize(lookup, details: nil, prefixes: nil)
      return lookup if lookup.is_a? self

      CustomLookupContext.new(
        lookup.view_paths,
        details || lookup.instance_variable_get('@details'),
        prefixes || lookup.prefixes
      )
    end

    # @note for Rails version 6 and above
    # It overrides the origin method to convert paths to {Wallaby::CellResolver}
    # @param paths [Array]
    # @return [ActionView::PathSet]
    def build_view_paths(paths)
      ActionView::PathSet.new Array(paths).map(&method(:convert))
    end

    # @note for Rails version below 6
    # It overrides the origin method to convert paths to {Wallaby::CellResolver}
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
      prefixes = [] if partial && name.include?(SLASH) # reset the prefixes if `/` is detected
      key = [name, prefixes, partial, keys, options].map(&:inspect).join(SLASH)
      cached_lookup[key] ||= super
    end

    protected

    # @!attribute [r] cached_lookup
    # Cached lookup result
    def cached_lookup
      @cached_lookup ||= {}
    end

    # Convert path to {Wallaby::CellResolver}
    # @param path [Object]
    # @return [Wallaby::CellResolver]
    def convert(path)
      case path
      when ActionView::OptimizedFileSystemResolver, Pathname, String
        CellResolver.new path.to_s
      else
        path
      end
    end
  end
end
