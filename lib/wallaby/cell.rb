# frozen_string_literal: true

module Wallaby
  # A Cell template/partial is a Ruby view object.
  class Cell
    VARIABLES = %i(
      @__context
      @__local_assigns
      @__buffer
    ).freeze

    KEYS = %w(
      __context
      __local_assigns
      __buffer
    ).freeze

    # @!attribute [r] context
    # @return [Object] view context
    def context
      @__context
    end

    # @!attribute [r] local_assigns
    # @return [Hash] a list of local_assigns
    def local_assigns
      @__local_assigns
    end

    # @!attribute [r] buffer
    # @return [String] output string buffer
    def buffer
      @__buffer
    end

    %i[object field_name value metadata form].each do |method_id|
      define_method method_id do
        local_assigns[method_id]
      end

      define_method "#{method_id}=" do |value|
        local_assigns[method_id] = value
      end
    end

    delegate(*ERB::Util.singleton_methods, to: ERB::Util)
    delegate :yield, :assigns, :concat, :render, to: :context

    # @param context [ActionView::Base] view context
    # @param local_assigns [Hash] local variables
    # @param buffer [ActionView::OutputBuffer.new, nil] output buffer
    def initialize(context = nil, local_assigns = nil, buffer = nil)
      update context, local_assigns, buffer
    end

    # @param context [ActionView::Base] view context
    # @param local_assigns [Hash] local variables
    # @param buffer [ActionView::OutputBuffer.new, nil] output buffer
    def update(context, local_assigns, buffer = nil)
      return unless context

      @__context = context
      @__local_assigns = local_assigns
      @__buffer = buffer || ActionView::OutputBuffer.new
    end

    # @note this is a template method that can be overridden by subclasses
    # Produce output for both the template and partial.
    # @return [ActionView::OutputBuffer, String]
    def to_render; end

    # @note this is a template method that can be overridden by subclasses
    # Produce output for the template.
    # @return [ActionView::OutputBuffer, String]
    def to_template(&block)
      to_render(&block)
    end

    # @note this is a template method that can be overridden by subclasses
    # Produce output for the partial.
    # @return [ActionView::OutputBuffer, String]
    def to_partial(&block)
      to_render(&block)
    end

    # Produce output for the {Wallaby::Cell} template.
    # @return [ActionView::OutputBuffer, String]
    def render_template(&block)
      to_buffer { to_template(&block) }
    end

    # Produce output for the {Wallaby::Cell} partial.
    # @return [ActionView::OutputBuffer, String]
    def render_partial(&block)
      to_buffer { to_partial(&block) }
    end

    private

    def to_buffer
      buffer_was = context.output_buffer
      context.output_buffer = @__buffer
      content = yield
      context.output_buffer = buffer_was
      buffer == content ? buffer : buffer << content
    end

    # Delegate missing method to {#context}
    def method_missing(method_id, *args, &block)
      return local_assigns[method_id] if local_assigns.key?(method_id)
      return super unless context.respond_to? method_id

      context.public_send method_id, *args, &block
    end

    # Delegate missing method check to {#context}
    def respond_to_missing?(method_id, _include_private)
      local_assigns.key?(method_id) || context.respond_to?(method_id) || super
    end
  end
end
