# frozen_string_literal: true

module Wallaby
  # Custom view renderer to provide support for cell rendering
  class CustomRenderer < ::ActionView::Renderer
    def initialize(lookup_context)
      super CustomLookupContext.normalize(lookup_context)
    end

    # @return [String] HTML output
    # @see Wallaby::CustomPartialRenderer
    def render_partial(context, options, &block) #:nodoc:
      CustomPartialRenderer.new(lookup_context).render(context, options, block)
    end
  end
end
