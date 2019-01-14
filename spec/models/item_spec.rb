# frozen_string_literal: true

# == Schema Information
#
# Table name: items
#
#  id                  :bigint(8)        not null, primary key
#  original_price      :float            not null
#  has_discount        :boolean          default(FALSE)
#  discount_percentage :integer          default(0)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  name                :string
#

require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'Database' do
    subject(:new_item) { described_class.new }

    it { is_expected.to have_db_column(:id).of_type(:integer) }
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:original_price).of_type(:float).with_options(null: false) }
    it { is_expected.to have_db_column(:has_discount).of_type(:boolean) }
    it { is_expected.to have_db_column(:discount_percentage).of_type(:integer).with_options(default: 0) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
  end

  describe 'Validations' do
    subject(:item) { create(:item) }

    context 'when factory is valid' do
      it { expect{ item }.to change(described_class, :count).by(1) }
      it { is_expected.to be_valid }
    end

    context 'when :discount_percentage' do
      it {
        expect(item).to validate_numericality_of(:discount_percentage).
          is_greater_than_or_equal_to(0).
          is_less_than_or_equal_to(100)
      }
    end
  end

  describe 'Price' do
    context "when the item doesn't has a discount" do
      subject(:item) { build(:item_without_discount) }

      it { expect(item.price).to eq(item.original_price) }
    end

    context 'when the item has a nil discount_percentage' do
      subject(:item) { build(:item_with_discount, discount_percentage: nil) }

      it { expect(item.price).to eq(item.original_price) }
    end

    context 'when the item has a discount' do
      subject(:item) { build(:item_with_discount, original_price: 100.00, discount_percentage: 20) }

      it { expect(item.price).to eq(80.00) }
    end

    context 'when price is a float' do
      subject(:item) { build(:item) }

      it { expect(item.price.class).to be(Float) }
    end
  end

  # describe 'average_price' do
  #   subject(:subject) { described_class }
  #
  #   context 'when average_price is nil when database is empty' do
  #     it { expect(subject.average_price).to eq(nil) }
  #   end
  #
  #   context 'when average_price is a float' do
  #     let!(:item) { create(:item) }
  #
  #     it { expect(subject.average_price.class).to be(Float) }
  #     it { expect(subject.average_price).to be(item.price) }
  #   end
  # end
end
