module Admin
  class CustomsController < Admin::UsersController
    self.prefix_options = { mapping_actions: { prefixes: 'form' } }

    def _prefixes
      super do |prefixes|
        prefixes.insert(prefixes.index('admin/customs'), 'super/man')
      end
    end
  end
end
