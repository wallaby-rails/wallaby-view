# frozen_string_literal: true

require 'request_store'
require 'action_view/partial_renderer'

require 'wallaby/view/version'
require 'wallaby/view/action_viewable'
require 'wallaby/view/themeable'
require 'wallaby/view/custom_lookup_context'
require 'wallaby/view/custom_prefixes'

module Wallaby # :nodoc:
  # To extend Rails prefixes and improve lookup performance.
  module View
    extend ActiveSupport::Concern

    # This is the method executed when this module is included by other modules.
    #
    # Basically, it renames the methods so that it is possible
    # to access the original methods after overriding them:
    #
    # 1. Rename the following original methods:
    #
    #     - rename {https://github.com/rails/rails/blob/master/actionview/lib/action_view/view_paths.rb#L97
    #       lookup_context} to {Wallaby::View::ActionViewable#original_lookup_context original_lookup_context}
    #     - rename {https://github.com/rails/rails/blob/master/actionview/lib/action_view/view_paths.rb#L90 _prefixes}
    #       to {Wallaby::View::ActionViewable#original_prefixes original_prefixes}
    #
    # 2. Override the original methods:
    #
    #     - rename {Wallaby::View::ActionViewable#override_lookup_context override_lookup_context}
    #       to {Wallaby::View::ActionViewable#lookup_context lookup_context}
    #     - rename {Wallaby::View::ActionViewable#override_prefixes override_prefixes}
    #       to {Wallaby::View::ActionViewable#\_prefixes \_prefixes}
    # @param mod [Module]
    def self.included(mod)
      mod.send :alias_method, :original_lookup_context, :lookup_context
      mod.send :alias_method, :original_prefixes, :_prefixes
      mod.send :alias_method, :lookup_context, :override_lookup_context
      mod.send :alias_method, :_prefixes, :override_prefixes
    end

    # Util method to check if the given subject responds to the given method.
    #
    # If so, it will send the message and return the result. Otherwise, nil.
    # @param subject [Object]
    # @param method_id [Symbol, String]
    # @param args [Array]
    # @return [Object, nil]
    def self.try_to(subject, method_id, *args, &block)
      return unless subject.respond_to?(method_id)

      subject.public_send(method_id, *args, &block)
    end

    COMMA = ',' # :nodoc:
    EMPTY_STRING = '' # :nodoc:
    DOT_RB = '.rb' # :nodoc:
    SLASH = '/' # :nodoc:
    EQUAL = '=' # :nodoc:
    UNDERSCORE = '_' # :nodoc:

    include ActionViewable
    include Themeable
  end
end
