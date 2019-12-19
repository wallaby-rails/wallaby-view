# frozen_string_literal: true

module Wallaby
  module View
    # Custom view renderer
    class CustomRenderer < ::ActionView::Renderer
      # Convert `lookup_context` into {Wallaby::View::CustomLookupContext}
      # @see Wallaby::View::CustomLookupContext
      def initialize(lookup_context)
        super CustomLookupContext.convert(lookup_context)
      end

      # Use {Wallaby::View::CustomPartialRenderer} to render partial/cell
      # @return [String] HTML output
      # @see Wallaby::View::CustomPartialRenderer
      def render_partial(context, options, &block)
        CustomPartialRenderer.new(lookup_context).render context, options, block
      end
    end
  end
end
