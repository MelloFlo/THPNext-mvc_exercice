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

class Item < ApplicationRecord
  validates :discount_percentage, numericality: { only_integer: true,
                                                  greater_than_or_equal_to: 0,
                                                  less_than_or_equal_to: 100 }
  def price
    if has_discount
      original_price.to_f * (1 - discount_percentage.to_f / 100)
    else
      original_price
    end
  end

  def self.average_price
    if count.zero?
      nil
    else
      (all.inject(0.0) { |total, item| total + _total = item.price } / count).round(2)
    end
  end
end
