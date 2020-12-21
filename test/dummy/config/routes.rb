Rails.application.routes.draw do
  namespace :admin, only: [] do
    get 'prefixes', to: 'application#prefixes'

    resource :user, only: [] do
      get 'prefixes'
    end

    resource :user_profile, only: [:show] do
      get 'prefixes'
    end

    resource :custom, only: [] do
      get 'prefixes'
      get 'prefix_options'
    end

    resource :custom_child, only: [] do
      get 'prefixes'
      get 'prefix_options'
    end

    resource :custom_grand_child, only: [] do
      get 'prefixes'
      get 'prefix_options'
    end
  end

  resource :collection, only: [] do
    get 'partials'
  end
end
