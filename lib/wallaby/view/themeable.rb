# frozen_string_literal: true

module Wallaby
  module View
    # Theme module
    module Themeable
      extend ActiveSupport::Concern

      class << self
        # @!attribute theme_name
        #   The theme name is used to apply a set of theme implementation
        #   for the frontend (html/css/javascript).
        #
        #   When theme name is set to e.g. `custom_theme`,
        #   the following changes will be made:
        #
        #   - layout will be set to the same name `custom_theme`
        #   - theme name will be added to the lookup prefixes
        #     right after the controller path of where it's defined.
        #
        #   Once theme name is set, all its subclass controllers
        #   will inherit the same theme name
        #   @example To set an theme name:
        #     class Admin::ApplicationController < ApplicationController
        #       self.theme_name = 'secure'
        #
        #       def index
        #         _prefixes
        #         # =>
        #         # [
        #         #   'admin/application/index',
        #         #   'admin/application',
        #         #   'secure/index',
        #         #   'secure',
        #         #   'application/index',
        #         #   'application'
        #         # ]
        #       end
        #     end
        #
        #     class Admin::UsersController < Admin::ApplicationController
        #       self.theme_name # => 'secure'
        #     end
        #   @return [String, nil] theme name

        # @!method theme
        #   @example Once theme is set, the metadata will be set as well:
        #     class Admin::UsersController < ApplicationController
        #       self.theme_name = 'secure'
        #
        #       self.theme
        #       # =>
        #       # {
        #       #   theme_name: 'secure',
        #       #   theme_path: 'admin/users'
        #       # }
        #     end
        #   @return [Hash] theme metadata

        # @!method themes
        #   @return [Array<Hash>] a list of theme metadata
      end

      class_methods do
        # @see {.theme_name}
        def theme_name=(theme_name)
          layout theme_name
          @theme_path = theme_name && controller_path
          @theme_name = theme_name
        end

        # @see {.theme_name}
        def theme_name
          defined?(@theme_name) ? @theme_name : superclass_s(:theme_name)
        end

        # @see {.theme}
        def theme
          defined?(@theme_name) && {
            theme_name: @theme_name,
            theme_path: @theme_path
          } || superclass_s(:theme)
        end

        # @see {.themes}
        def themes
          parent_themes = superclass_s(:themes) || []
          (defined?(@theme_name) ? [theme] : []).concat(parent_themes).compact
        end

        private

        def superclass_s(method)
          superclass.respond_to?(method) && superclass.public_send(method) || nil
        end
      end
    end
  end
end
