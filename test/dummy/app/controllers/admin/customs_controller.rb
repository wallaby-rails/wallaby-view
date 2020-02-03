module Admin
  class CustomsController < Admin::UsersController
    def _prefixes
      super(
        options: { mapping_actions: { 'prefixes' => 'form' } }
      ) do |prefixes|
        prefixes.prepend('super/man')
      end
    end
  end
end
