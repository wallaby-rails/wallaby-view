# frozen_string_literal: true

module Wallaby
  # Resolver to provide support for cell and partial
  # @since 5.2.0
  class CellResolver < ActionView::OptimizedFileSystemResolver
    # for Rails 5.2 and below
    begin
      # A cell query looks like:
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
      # @param path [String]
      # @param details [Hash]
      #   see {https://api.rubyonrails.org/classes/ActionView/LookupContext/ViewPaths.html#method-i-detail_args_for
      #   Detials from ViewPaths}
      # @return [String] a path query
      def build_query(path, details)
        # NOTE: super is impacted by {#escape_entry}
        origin = super
        file_name = origin[%r{(?<=/\{,_\})[^/\{]+}]
        return origin unless file_name

        base_dir = origin.gsub(%r{/[^/]*$}, '')
        locales = convert details[:locale]
        formats = convert details[:formats]
        cell = "#{base_dir}/#{file_name}{#{locales}}{#{formats}}.rb"
        "{#{cell},#{origin}}"
      end
    end

    # for Rails 6 and above
    begin
      def find_template_paths_from_details(path, details)
        details[:handlers].unshift(:rb) if details[:handlers].try(:first) != :rb
        super
      end

      def build_regex(path, details)
        origin = super.source
        Regexp.new(
          origin
            .gsub(%r{/\{,_\}([^/]+)\z}, '/_?\\1')
            .gsub('\\.', '[_\\.]')
            .gsub('raw|', 'rb|raw|')
        )
      end
    end

    def escape_entry(entry)
      super.gsub(%r{/_([^/]+)\z}, '/{,_}\1')
    end

    private

    # @example concat a list of values into a string
    #   convert(['html', 'csv']) # => '_html,_cvs,'
    # @param values [Array<String>]
    def convert(values)
      (values.map { |v| "_#{v}" } << '').join ','
    end
  end
end
