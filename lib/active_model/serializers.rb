require 'active_support'
require 'active_support/lazy_load_hooks'
require 'active_model'
require "active_model/serializers/version"

ActiveSupport.on_load(:active_record) do
  require "active_record/serializers/xml_serializer"
end

module ActiveModel
  module Serializers
    extend ActiveSupport::Autoload

    eager_autoload do
      autoload :Xml
    end
  end

  def self.eager_load!
    super
    ActiveModel::Serializers.eager_load!
  end
end

module ActiveRecord
  module ModelSchema
    extend ActiveSupport::Concern

    class_methods do
      def xml_version
        @xml_version ||= '1.0'
      end

      def xml_version=(value)
        value = value&.to_s
        @xml_version = value
      end

      def xml_encoding
        @xml_encoding ||= 'UTF-8'
      end

      def xml_encoding=(value)
        value = value&.to_s
        @xml_encoding = value
      end

      def xml_attributes(*attributes)
        if attributes.present?
          @xml_attributes ||= attributes
        else
          @xml_attributes || {}
        end
      end
    end
  end
end