# frozen_string_literal: true

module Wallaby
  module View
    # Custom path set to convert the found template for {Wallaby::Cell}
    # into a {Wallaby::View::CustomTemplate}.
    class CustomPathSet < ::ActionView::PathSet
      # Find template as usual, but only convert the found template for {Wallaby::Cell}
      # into a {Wallaby::View::CustomTemplate}.
      # @overload find(name, prefixes = [], partial = false, keys = [], options = {})
      #   @param name [String] name of the template/partial/{Wallaby::Cell}
      #   @param prefixes [Array<String>]
      #   @param partial [true, false]
      #   @param keys [Array<String, Symbol>] keys of the locals variables
      #   @param options [Hash] options for the lookup
      #   @return [ActiveView::Template,Wallaby::View::CustomTemplate]
      #   @see ActionView::LookupContext#find
      def find(*args)
        super.try do |template|
          cell_class = cell_class_from template
          next template unless cell_class

          CustomTemplate.convert template, cell_class, args[2]
        end
      end

      protected

      # Check if the given template is a {Wallaby::Cell} or not
      # from the `identifier` and `inspect` values.
      # @param template [ActionView::Template]
      # @return [String] {Wallaby::Cell} class
      def cell_class_from(template)
        base_name = template.virtual_path.gsub %r{/[^/]+\z}, EMPTY_STRING

        [template.identifier, template.inspect].map do |path|
          next unless path.end_with?(DOT_RB)

          begin
            snake_class = path[/#{base_name}.+(?=\.rb)/]
            snake_class.camelize.constantize.try { |c| c < Cell && c || nil }
          rescue NameError, LoadError # rubocop:disable Lint/SuppressedException
          end
        end.find(&:presence)
      end

      # Type cast all paths to {Wallaby::View::CustomResolver}
      # so that it's possible to support {Wallaby::Cell} lookup.
      # @param paths [Array<Wallaby::View::CustomResolver,ActionView::OptimizedFileSystemResolver,Pathname,String>]
      # @return [Array<Wallaby::View::CustomResolver>]
      def typecast(paths)
        paths.map do |path|
          case path
          when ActionView::OptimizedFileSystemResolver, Pathname, String
            CustomResolver.new path.to_s
          else
            path
          end
        end
      end
    end
  end
end
