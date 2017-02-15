# frozen_string_literal:true

class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.text :name, null: false

      t.timestamps null: false
    end
  end
end
