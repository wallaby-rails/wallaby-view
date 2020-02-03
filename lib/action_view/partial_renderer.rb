# frozen_string_literal: true

module ActionView # :nodoc:
  # Re-open ActionView::PartialRenderer to disable logging for partials
  # that have been rendered for more than once.
  #
  # Every log requires the IO. Reducing the logs will dramatically improve the performance.
  # @see #instrument
  class PartialRenderer
    protected

    # @!method original_instrument(name, **options, &block)
    # Original method of {#instrument}
    # @param name [String]
    # @param options [Hash]
    alias original_instrument instrument

    # Logs for partial rendering. Only one log will be printed
    # even if a partial has been rendered for more than once.
    #
    # To disable this feature and see all logs,
    # set `ENV['PARTIAL_INSTRUMENT_DISABLED']` to `true`
    # @param name [String]
    # @param options [Hash]
    def instrument(name, **options, &block)
      identifier = options[:identifier] || @template.try(:identifier) || @path
      instrumented = RequestStore.store[:instrumented] ||= {}

      return yield({}) if !ENV['PARTIAL_INSTRUMENT_DISABLED'] && instrumented[identifier]

      original_instrument(name, **options, &block).tap do
        instrumented[identifier] ||= true
      end
    end
  end
end
