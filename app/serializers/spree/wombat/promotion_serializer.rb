require 'active_model_serializers'

module Spree
  module Wombat
    class PromotionSerializer < ActiveModel::Serializer
      attributes :name, :code, :codes, :category_name, :category_code

      def category_name
        object.promotion_category.try(:name)
      end

      def category_code
        object.promotion_category.try(:code)
      end

      def code
        codes.first
      end

      def codes
        gather_codes.sort
      end

      private

      def gather_codes
        all_codes = object.codes
        if object.new_record?
          all_codes.collect(&:value)
        else
          all_codes.pluck(:value)
        end
      end
    end
  end
end
