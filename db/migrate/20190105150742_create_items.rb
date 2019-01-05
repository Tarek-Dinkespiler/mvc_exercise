# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.float :original_price, null: false
      t.boolean :has_discount, default: false
      t.integer :discount_percentage, default: 0

      t.timestamps
    end
  end
end
