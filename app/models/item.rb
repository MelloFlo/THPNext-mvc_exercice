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
  def price
    if has_discount
      original_price.to_f * (1 - discount_percentage.to_f / 100)
    else
      original_price
    end
  end

  def self.average_price
    total = 0
    items = Item.all
    items.each do |item|
      total += item.price
    end
    total /= Item.count
  end
end
