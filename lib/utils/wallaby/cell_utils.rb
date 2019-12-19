# frozen_string_literal: true

module Wallaby
  module View
    # Cell utils
    module CellUtils
      class << self
        # @param action_name [String, Symbol]
        # @return [String, Symbol] action prefix
        def to_action_prefix(action_name)
          FORM_ACTIONS[action_name] || action_name
        end
      end
    end
  end
end
