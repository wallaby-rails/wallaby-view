module Admin
  class CustomsController < Admin::UsersController
    self.prefix_options = { prefixes: ['form'] }

    def _prefixes
      super do |prefixes|
        prefixes.insert(prefixes.index('admin/customs'), 'super/man')
      end
    end

    def prefix_options
      render json: self.class.prefix_options
    end
  end
end
