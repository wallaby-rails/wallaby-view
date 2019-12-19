# frozen_string_literal: true

module Wallaby
  module View
    # This error class will be raised once a cell file is identified.
    class RenderCell < ::StandardError
      attr_reader :full_path, :partial

      # @param full_path [String]
      # @param partial [ActionView::Template]
      def initialize(full_path, partial)
        super full_path
        @full_path = full_path
        @partial = partial
      end
    end

    # Custom partial renderer
    class CustomPartialRenderer < ::ActionView::PartialRenderer
      # Override origin method to stop partial rendering when a cell is found.
      # @return [ActionView::Template] partial template
      # @raise [Wallaby::View::RenderCell] when a cell is found
      def find_partial(*args)
        super.tap do |partial|
          full_path = cell_path_from partial
          raise RenderCell.new(full_path, partial) if full_path
        end
      end

      # Override to provide support for cell rendering.
      #
      # The way it works is that once a cell is found, an exception {Wallaby::View::RenderCell} will be
      # raised from {#find_partial} and captured in here so that cell can be rendered separately.
      #
      # @param context [ActionView::Context]
      # @param options [Hash]
      # @param block [Proc]
      # @return [String] HTML output
      def render(context, options, block)
        rendered = super
        # Rails 6 and above
        rendered = rendered.body if rendered.respond_to? :body
        rendered
      rescue RenderCell => e
        cell_class = cell_class_from e.full_path, e.partial
        cell_class.new(context, options[:locals]).render_to_body(&block).tap do
          Rails.logger.info "  Rendered [cell] #{e.full_path}"
        end
      end

      protected

      # Get the cell class name
      # @param context [ActionView::Context]
      # @param full_path [string]
      # @param partial [ActionView::Template]
      # @param locals [Hash]
      # @return [String] HTML output
      def cell_class_from(full_path, partial)
        start_with = partial.virtual_path.gsub %r{/[^/]+\z}, EMPTY_STRING
        snake_class = full_path[/#{start_with}.+(?=\.rb)/]
        snake_class.camelize.constantize
      end

      # @param partial [ActionView::Template]
      # @return [String] cell path
      def cell_path_from(partial)
        [partial.identifier, partial.inspect].find do |path|
          fragments = path.split DOT
          fragments.length == 2 && fragments.last == RB
        end
      end
    end
  end
end
