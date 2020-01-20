# frozen_string_literal: true

module Wallaby
  module View
    # Custom prefix builder to provide more lookup prefix paths.
    class CustomPrefixes < Struct.new( # rubocop:disable Style/StructInheritance
      :prefixes, :action_name, :theme_name, :options
    )
      # @param lookup_context [ActionView::LookupContext]
      # @param details [Hash]
      # @param prefixes [Array]
      def self.build(prefixes:, action_name:, theme_name: nil, options: nil, &block)
        new(prefixes, action_name, theme_name, options || {}).build(&block)
      end

      def build(&block)
        new_prefixes =
          if block_given?
            instance_exec(prefixes_with_theme_name, &block)
          else
            prefixes_with_theme_name
          end
        new_prefixes.each_with_object([]) do |prefix, array|
          array << "#{prefix}/#{suffix}" << prefix
        end
      end

      protected

      def prefixes_with_theme_name
        @prefixes_with_theme_name ||=
          prefixes.dup.tap do |array|
            array.insert theme_index, theme_name if theme_name
          end
      end

      def theme_index
        @theme_index ||=
          options[:theme_index].try do |index|
            index = prefixes.index index if index.is_a? String
            index || -1 # generally, -1 is `application`
          end
      end

      def suffix
        @suffix ||= options[:actions].try(:[], action_name) || action_name
      end
    end
  end
end
