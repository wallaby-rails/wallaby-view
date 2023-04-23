# frozen_string_literal: true

module Admin
  class CustomGrandChildrenController < CustomsController
    merge_prefix_options index: 'grand'
  end
end
