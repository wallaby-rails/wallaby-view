# frozen_string_literal: true

module Wallaby
  module View
    # Wallaby engine
    class Railtie < ::Rails::Railtie
      initializer 'wallaby.view.autoload_paths', before: :set_load_path do |app|
        # NOTE: this needs to be run before `set_load_path`
        # so that all cell files under `app/views` can be eager loaded
        # and therefore, Wallaby's renderer can function properly
        app.config.paths.tap do |paths|
          next if paths['app/views'].eager_load?
          paths.add 'app/views', eager_load: true
        end
      end
    end
  end
end
