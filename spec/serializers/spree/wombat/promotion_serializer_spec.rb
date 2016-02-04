require 'spec_helper'

module Spree
  module Wombat
    describe PromotionSerializer, type: :serializer do
      let(:promotion) do
        Spree::Promotion.new(name: "Promo").tap do |promo|
          promo.promotion_codes << Spree::PromotionCode.new(value: "pro")
        end
      end
      let(:serializer) { PromotionSerializer.new(promotion, root: false) }
      let(:serialized) { JSON.parse(serializer.to_json) }
      let(:faux_codes) { ['not', 'in', 'order'] }

      before { promotion.build_promotion_category(name: "Category", code: "cat") }

      it { expect(serialized['codes']).to eq ['pro'] }
      it { expect(serialized['name']).to eq 'Promo' }
      it { expect(serialized['category_code']).to eq 'cat' }
      it { expect(serialized['category_name']).to eq 'Category' }

      context '#code' do
        it 'picks the first entry in codes' do
          allow(serializer).to receive(:gather_codes).and_return(faux_codes)
          expect(serializer.code).to eq('in')
        end
      end

      context '#codes' do
        it 'orders the results' do
          allow(serializer).to receive(:gather_codes).and_return(faux_codes)
          expect(serializer.codes).to eq(['in', 'not', 'order'])
        end
      end
    end
  end
end
