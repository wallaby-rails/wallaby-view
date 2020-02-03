class ApplicationController < ActionController::Base
  include Wallaby::View

  def prefixes
    render json: _prefixes
  end
end
