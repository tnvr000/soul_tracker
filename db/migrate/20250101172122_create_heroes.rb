class CreateHeroes < ActiveRecord::Migration[8.0]
  def change
    create_table :heroes do |t|
      t.references :user
      t.string :name
      t.integer :hero_class
      t.integer :hero_type
      t.integer :hero_role
      t.integer :hero_style
      t.integer :level
      t.integer :stars
      t.integer :combat_power
      t.integer :hit_point
      t.integer :defense
      t.integer :attack
      t.integer :speed
      t.integer :count, default: 1
      t.string :unique_key, null: false
      t.index :unique_key, unique: true

      t.timestamps
    end
  end
end
