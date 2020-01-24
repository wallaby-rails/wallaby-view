module Admin
  class ApplicationController < ::ApplicationController
    self.theme_name = 'secure'

    def display_prefixes
      render json: _prefixes
    end
  end
end
