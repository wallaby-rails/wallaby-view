# frozen_string_literal: true

module Wallaby
  module View
    # Custom resolver responsible for adding support for {Wallaby::Cell} lookup.
    class CustomResolver < ActionView::OptimizedFileSystemResolver
      # @note for Rails 5.2 and below
      begin
        # A cell query looks like the following:
        #
        # ```
        # app/views/wallaby/resources/index/integer{_en,}{_html,}.rb
        # ```
        #
        # Wallaby adds it to the front of the whole query as below:
        #
        # ```
        # {app/views/wallaby/resources/index/integer{_en,}{_html,}.rb,
        # app/views/wallaby/resources/index/_integer{.en,}{.html,}{.erb,}}
        # ```
        #
        # Then when {Wallaby::View::CustomResolver} does the lookup, it will return
        # the {Wallaby::Cell} template before anything else.
        # @param path [String]
        # @param details [Hash]
        #   see {https://api.rubyonrails.org/classes/ActionView/LookupContext/ViewPaths.html#method-i-detail_args_for
        #   Detials from ViewPaths}
        # @return [String] a path query
        def build_query(path, details)
          # NOTE: super is impacted by {#escape_entry}
          origin = super
          base_dir = origin.gsub(%r{/[^/]*\z}, EMPTY_STRING)
          locales = convert details[:locale]
          formats = convert details[:formats]
          cell_query = "#{base_dir}/#{file_name}{#{locales}}{#{formats}}.rb"
          "{#{cell_query},#{origin}}"
        end
      end

      # @note for Rails 6 and above
      begin
        # This is a hack, we need to add rb extension to the beginning
        # of handlers list to make {Wallaby::View::CustomResolver}
        # to look up {Wallaby::Cell} file at higher precedence.
        # @param path [String]
        # @param details [Hash]
        #   see {https://api.rubyonrails.org/classes/ActionView/LookupContext/ViewPaths.html#method-i-detail_args_for
        #   Detials from ViewPaths}
        def find_template_paths_from_details(path, details)
          # NOTE: this is a fix for `sort_by` inside of `super` method
          details[:handlers].unshift(:rb) if details[:handlers].try(:first) != :rb
          super
        end

        # This is to extend the current expression to allow resolver to look up
        # {Wallaby::Cell} file.
        # @param path [String]
        # @param details [Hash]
        #   see {https://api.rubyonrails.org/classes/ActionView/LookupContext/ViewPaths.html#method-i-detail_args_for
        #   Detials from ViewPaths}
        def build_regex(path, details)
          Regexp.new(
            super.source
              .gsub(%r{/\{,_\}([^/]+)\z}, '/_?\\1')
              .gsub('\\.', '[_\\.]')
              .gsub('raw|', 'rb|raw|')
          )
        end
      end

      # Replace partial e.g. `/_string` with `/{,_}string` so that
      # {Wallaby::Cell} file e.g. `/string_html.rb` can be searched
      # at higher precedence.
      # @param entry [String]
      # @return [String] escaped entry
      def escape_entry(entry)
        super.gsub(%r{/_([^/]+)\z}, '/{,_}\1')
      end

      private

      # @example concat a list of values into a string
      #   convert(['html', 'csv']) # => '_html,_cvs,'
      # @param values [Array<String>]
      # @return [String]
      def convert(values)
        (values.map { |v| "_#{v}" } << EMPTY_STRING).join COMMA
      end
    end
  end
end
