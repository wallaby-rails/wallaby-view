# frozen_string_literal: true

module Wallaby
  module View
    # Custom path set to convert the found template for {Wallaby::Cell}
    # into a {Wallaby::View::CustomTemplate}.
    class CustomPathSet < ::ActionView::PathSet
      protected

      # Type cast all paths to {Wallaby::View::CustomResolver}
      # so that it's possible to support {Wallaby::Cell} lookup.
      # @param paths [Array<Wallaby::View::CustomResolver,ActionView::OptimizedFileSystemResolver,Pathname,String>]
      # @return [Array<Wallaby::View::CustomResolver>]
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
