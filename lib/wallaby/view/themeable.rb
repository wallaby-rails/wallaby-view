# frozen_string_literal: true

module Wallaby
  module View
    # Theme module
    module Themeable
      extend ActiveSupport::Concern

      class_methods do
        # @!attribute [w] theme_name
        def theme_name=(theme_name)
          layout theme_name
          @theme_name = theme_name
        end

        # @!attribute [r] theme_name
        # The theme name is used to apply a set of frontend (html/css/javascript) implementation.
        #
        # When theme name is set to e.g. `custom_theme`, the following changes will be made:
        #
        # - layout will be set to the same name `custom_theme`
        # - it will be added to the partial lookup prefixes right on top of `wallaby/resources` prefix.
        #
        # Once theme name is set, all its controller subclasses will inherit the same theme name
        # @example To set an theme name:
        #   class Admin::ApplicationController < Wallaby::ResourcesController
        #     self.theme_name = 'admin_theme'
        #   end
        # @return [String, Symbol, nil] theme name
        def theme_name
          @theme_name ||=
            superclass.respond_to?(:theme_name) && superclass.theme_name
        end
      end

      # @return [String, Symbol, nil] theme name
      def current_theme_name
        self.class.theme_name
      end
    end
  end
end
