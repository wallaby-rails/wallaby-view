# frozen_string_literal: true

module Wallaby
  module View
    # Custom prefix builder to add more lookup prefix paths to given {#prefixes}.
    class CustomPrefixes
      include ActiveModel::Model

      # @!attribute prefixes
      #   @return [Array<String>]
      #   @see Wallaby::View::ActionViewable#_prefixes
      attr_accessor :prefixes
      # @!attribute action_name
      #   @return [String]
      attr_accessor :action_name
      # @!attribute themes
      #   @return [Array<Hash>]
      #   @see Wallaby::View::Themeable#.themes
      attr_accessor :themes
      # @!attribute options
      #   @return [Hash]
      attr_accessor :options

      # @param prefixes [Array<String>]
      # @param action_name [String]
      # @param themes [String, nil]
      # @param options [Hash, nil]
      # @return [Array<String>]
      def self.execute(
        prefixes:, action_name:, themes: nil, options: nil, &block
      )
        new(
          prefixes: prefixes,
          action_name: action_name,
          themes: themes,
          options: (options || {}).with_indifferent_access
        ).execute(&block)
      end

      def execute(&block)
        new_prefixes(&block).each_with_object([]) do |prefix, array|
          # Extend the prefix with action name suffix
          array << "#{prefix}/#{suffix}" << prefix
        end
      end

      private

      def new_prefixes(&block)
        prefixes.dup.try do |array|
          insert_themes_into array

          # Be able to change the array in overriding methods
          # in {Wallaby::View::ActionViewable#override_prefixes}
          new_array = instance_exec(array, &block) if block_given?

          # If the above block doesn't return an array,
          # it's assumed that `array` is changed
          new_array.is_a?(Array) ? new_array : array
        end
      end

      # Action name suffix
      def suffix
        @suffix ||= mapped_action_name || action_name
      end

      # Insert theme name into the prefixes
      def insert_themes_into(array)
        themes.each do |theme|
          index = array.index theme[:theme_path]
          array.insert(index + 1, theme[:theme_name]) if index
        end
      end

      # Map the {#action_name} using `options[:mapping_actions]`
      # @return [String, nil] mapped action name
      def mapped_action_name
        options[:mapping_actions].try(:[], action_name)
      end
    end
  end
end
