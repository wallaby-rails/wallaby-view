# frozen_string_literal: true

module Wallaby
  # In order to improve the rendering performance, cell is designed as simple partial component.
  class Cell
    # @!attribute [r] context
    # @return [Object] view context
    attr_reader :context

    # @!attribute [r] local_assigns
    # @return [Hash] a list of local_assigns
    attr_reader :local_assigns

    # @!attribute [r] buffer
    # @return [String] output string buffer
    attr_reader :buffer

    delegate(*ERB::Util.singleton_methods, to: ERB::Util)
    delegate :yield, :formats, to: :context

    # @param context [ActionView::Base] view context
    # @param local_assigns [Hash] local variables
    # @param buffer [ActionView::OutputBuffer.new, nil] output buffer
    def initialize(context, local_assigns, buffer = nil)
      @context = context
      @local_assigns = local_assigns
      @buffer = buffer ||= ActionView::OutputBuffer.new
      context.output_buffer ||= buffer
    end

    # @note this is a template method that can be overridden by subclasses
    # Produce output for both the template and partial.
    def to_render; end

    # @note this is a template method that can be overridden by subclasses
    # Produce output for the template.
    def to_template
      to_render
    end

    # @note this is a template method that can be overridden by subclasses
    # Produce output for the partial.
    def to_partial
      to_render
    end

    # Produce output for the template.
    # @return [ActionView::OutputBuffer]
    def render_template(&block)
      content = to_template(&block)
      buffer == content ? buffer : buffer << content
    end

    # Produce output for the partial.
    # @return [ActionView::OutputBuffer]
    def render_partial(&block)
      content = to_partial(&block)
      buffer == content ? buffer : buffer << content
    end

    # @overload at(name)
    #   Get view instance variable value
    #   @example To get view instance variable value
    #     at('name') # => get value of `@name` from the view
    #   @param name [String, Symbol] view instance variable name without `@`
    # @overload at(name, value)
    #   Set view instance variable value
    #   @example To set view instance variable value
    #     at('name', value) # => set value of `@name` in the view
    #   @param name [String, Symbol] view instance variable name without `@`
    #   @param value [object] value
    # @return [object] view instance variable value
    def at(*args)
      raise ArgumentError unless args.length.in? [1, 2]
      return context.instance_variable_get :"@#{args.first}" if args.length == 1

      context.instance_variable_set :"@#{args.first}", args.last
    end

    private

    # Delegate missing method to {#context}
    def method_missing(method_id, *args, &block)
      return local_assigns[method_id] if local_assigns_reader?(method_id)
      return local_assigns[method_id[0..-2]] = args.first if local_assigns_writter?(method_id)

      return super unless context.respond_to? method_id

      context.public_send method_id, *args, &block
    end

    # Delegate missing method check to {#context}
    def respond_to_missing?(method_id, _include_private)
      local_assigns_reader?(method_id) \
        || local_assigns_writter?(method_id) \
        || context.respond_to?(method_id) \
        || super
    end

    # Check if the method_id is a key of {#local_assigns}
    def local_assigns_reader?(method_id)
      local_assigns.key?(method_id)
    end

    # Check if the method_id is a key assignment of {#local_assigns}
    def local_assigns_writter?(method_id)
      method_string = method_id.to_s
      method_string.end_with?(View::EQUAL) && local_assigns.key?(method_string[0..-2])
    end
  end
end
