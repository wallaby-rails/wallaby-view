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
          format: template.formats.first,
          variant: template.variants.first,
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
        p = proc do
          cell = cell_class.new view, locals, buffer
          partial ? cell.render_partial(&block) : cell.render_template(&block)
        end

        respond_to?(:instrument_render_template) ? instrument_render_template(&p) : instrument('!render_template', &p)
      rescue StandardError => e
        handle_render_error(view, e)
      end
    end
  end
end
