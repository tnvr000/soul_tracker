class CreateEquipments < ActiveRecord::Migration[8.0]
  def change
    create_table :equipments do |t|
      t.references :user
      t.string :name
      t.integer :equipment_type
      t.integer :equipment_style
      t.integer :equipment_class
      t.integer :equipment_class_level
      t.integer :level, default: 0
      t.string :unique_key, null: false
      t.index :unique_key

      t.timestamps
    end
  end
end
