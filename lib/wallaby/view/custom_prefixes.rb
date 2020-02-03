# frozen_string_literal: true

module Wallaby
  module View
    # Custom prefix builder to add more lookup prefix paths to given {#prefixes}.
    class CustomPrefixes
      # @!attribute [r] prefixes
      # @return [Array<String>]
      # @see Wallaby::View::ActionViewable#_prefixes
      attr_reader :prefixes
      # @!attribute [r] action_name
      # @return [String]
      attr_reader :action_name
      # @!attribute [r] themes
      # @return [Array<Hash>]
      # @see Wallaby::View::Themeable#.themes
      attr_reader :themes
      # @!attribute [r] options
      # @return [Hash]
      attr_reader :options

      # @example To extend given prefixes:
      #   Wallaby::View::CustomPrefixes.execute(
      #     prefixes: ['users', 'application'], action_name: 'index'
      #   )
      #   # => [
      #   #   'users/index',
      #   #   'users',
      #   #   'application/index',
      #   #   'application'
      #   # ]
      # @example To extend given prefixes with themes:
      #   Wallaby::View::CustomPrefixes.execute(
      #     prefixes: ['users', 'application'], action_name: 'index',
      #     themes: [{ theme_name: 'secure', theme_path: 'users' }]
      #   )
      #   # => [
      #   #   'users/index',
      #   #   'users',
      #   #   'secure/index',
      #   #   'secure',
      #   #   'application/index',
      #   #   'application'
      #   # ]
      # @example To extend given prefixes with mapped action:
      #   Wallaby::View::CustomPrefixes.execute(
      #     prefixes: ['users', 'application'], action_name: 'edit',
      #     options: { mapping_actions: { 'edit' => 'form' } }
      #   )
      #   # => [
      #   #   'users/form',
      #   #   'users',
      #   #   'application/form',
      #   #   'application'
      #   # ]
      # @param prefixes [Array<String>]
      # @param action_name [String]
      # @param themes [String, nil]
      # @param options [Hash, nil]
      # @return [Array<String>]
      # @see #execute
      def self.execute(
        prefixes:, action_name:, themes: nil, options: nil, &block
      )
        new(
          prefixes: prefixes, action_name: action_name,
          themes: themes, options: options
        ).execute(&block)
      end

      # @param prefixes [Array<String>]
      # @param action_name [String]
      # @param themes [String]
      # @param options [Hash]
      def initialize(prefixes:, action_name:, themes:, options:)
        @prefixes = prefixes
        @action_name = action_name
        @themes = themes
        @options = (options || {}).with_indifferent_access
      end

      # @return [Array<String>]
      def execute(&block)
        new_prefixes(&block).each_with_object([]) do |prefix, array|
          # Extend the prefix with action name suffix
          array << "#{prefix}/#{suffix}" << prefix
        end
      end

      private

      # @return [Array<String>]
      def new_prefixes
        prefixes.dup.try do |array|
          insert_themes_into array

          # Be able to change the array in overriding methods
          # in {Wallaby::View::ActionViewable#override_prefixes}
          new_array = yield array if block_given?

          # If the above block doesn't return an array,
          # it's assumed that `array` is changed
          new_array.is_a?(Array) ? new_array : array
        end
      end

      # Action name suffix
      # @return [Hash]
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
