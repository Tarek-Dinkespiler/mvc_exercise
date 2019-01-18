# frozen_string_literal: true

class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
  end
end
