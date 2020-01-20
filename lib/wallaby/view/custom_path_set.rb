# frozen_string_literal: true

module Wallaby
  module View
    # Custom path set to convert the found {Wallaby::Cell} template
    # to {Wallaby::View::CustomTemplate}
    class CustomPathSet < ::ActionView::PathSet
      # Find template as usual, but then convert the template
      # into {Wallaby::View::CustomTemplate} for {Wallaby::Cell}
      # @param args [Array]
      # @return [ActiveView::Template,Wallaby::View::CustomTemplate]
      def find(*args)
        super.try do |template|
          cell_class = cell_class_from template
          next template unless cell_class

          CustomTemplate.convert template, cell_class, args[2]
        end
      end

      protected

      # Try to find out the {Wallaby::Cell} class
      # from the `identifier` and `inspect` of ActionView::Template
      # @param template [ActionView::Template]
      # @return [String] {Wallaby::Cell} class
      def cell_class_from(template)
        base_name = template.virtual_path.gsub %r{/[^/]+\z}, EMPTY_STRING

        [template.identifier, template.inspect].map do |path|
          next unless path.end_with?(DOT_RB)

          begin
            snake_class = path[/#{base_name}.+(?=\.rb)/]
            snake_class.camelize.constantize.try { |c| c < Cell && c || nil }
          rescue NameError # rubocop:disable Lint/SuppressedException
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
