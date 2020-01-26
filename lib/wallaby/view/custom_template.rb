# frozen_string_literal: true

module Wallaby
  module View
    # Custom template for {Wallaby::Cell} file.
    class CustomTemplate < ::ActionView::Template
      # @!attribute cell_class
      #   @return [Class] a Class inheriting from {Wallaby::Cell}
      attr_accessor :cell_class
      # @!attribute partial
      #   @return [true, false] a flag to see if it's a partial or not
      attr_accessor :partial

      # Convert a template to {Wallaby::View::CustomTemplate} instance
      # @param template [ActionView::Template]
      # @param cell_class [Class]
      # @param partial [true, false]
      # @return [Wallaby::View::CustomTemplate]
      def self.convert(template, cell_class, partial)
        new(
          template.source, template.identifier, template.handler,
          format: template.send(:format),
          variant: template.send(:variant),
          locals: template.locals,
          virtual_path: template.virtual_path
        ).tap do |new_template|
          new_template.cell_class = cell_class
          new_template.partial = partial
        end
      end

      # Render {Wallaby::Cell} template/partial.
      #
      # - For a {Wallaby::Cell} template, it will use {Wallaby::Cell#to_template} for rendering.
      # - For a {Wallaby::Cell} partial, it will use {Wallaby::Cell#to_partial} for rendering.
      #
      # Otherwise, {Wallaby::Cell#to_render} can be used for both {Wallaby::Cell} template and partial.
      # @param view [ActionView::LookupContext]
      # @param locals [Hash]
      # @param buffer [ActionView::OutputBuffer]
      # @return [ActionView::OutputBuffer]
      def render(view, locals, buffer = ActionView::OutputBuffer.new, &block)
        instrument('!render_template') do
          cell = cached_cell view, locals, buffer
          partial ? cell.render_partial(&block) : cell.render_template(&block)
        end
      rescue StandardError => e
        handle_render_error(view, e)
      end

      protected

      def cached_cell(view, locals, buffer)
        @cached_cell ||= cell_class.new
        @cached_cell.update view, locals, buffer
        @cached_cell
      end
    end
  end
end
