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
#

FactoryBot.define do
  factory :item do
    original_price      { Faker::Number.decimal(2) }
    has_discount        { Faker::Boolean.boolean }

    trait :with_discount do
      has_discount { true }
    end

    factory :item_with_discount, traits: %i[with_discount]
  end
end
