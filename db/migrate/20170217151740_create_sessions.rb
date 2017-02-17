# frozen_string_literal:true

class CreateSessions < ActiveRecord::Migration[5.0]
  def change
    create_table :sessions do |t|
      t.references :user, index: true, foreign_key: true
      t.references :game, index: true, foreign_key: true
      t.integer :rating, null: false
      t.integer :players, null: false
      t.text :notes

      t.timestamps null: false
    end
  end
end
