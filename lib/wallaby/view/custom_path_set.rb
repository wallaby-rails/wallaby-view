# frozen_string_literal: true

module Wallaby
  module View
    # A custom lookup context that uses {Wallaby::CustomResolver} to find cell/partial
    class CustomPathSet < ::ActionView::PathSet
      protected

      def typecast(paths)
        paths.map do |path|
          case path
          when ActionView::OptimizedFileSystemResolver, Pathname, String
            CustomResolver.new path.to_s
          else
            path
          end
        end
      end
    end
  end
end
