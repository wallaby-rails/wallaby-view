class PagesController < ApplicationController
  include Wallaby::View
  # include Wallaby::RailsOverriddenMethods
  # include Wallaby::Engineable
  include Wallaby::Themeable
  include Wallaby::SharedHelpers
  include Wallaby::Resourcable

  def index
    lookup_context
  end
end
