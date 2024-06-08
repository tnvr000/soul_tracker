class CreateHeros < ActiveRecord::Migration[7.1]
  def change
    create_table :heros do |t|
      t.string :name
      t.integer :hero_class
      t.integer :hero_type
      t.integer :level
      t.integer :stars
      t.integer :hero_role
      t.integer :hero_style
      t.integer :combat_power
      t.integer :hit_point
      t.integer :defence
      t.integer :attack
      t.integer :speed

      t.timestamps
    end
  end
end
