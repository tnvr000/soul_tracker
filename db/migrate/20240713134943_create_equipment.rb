class CreateEquipment < ActiveRecord::Migration[7.1]
  def change
    create_table :equipment do |t|
      t.string :name
      t.integer :equipment_type
      t.integer :equipment_style
      t.integer :equipment_class
      t.integer :equipment_class_level
      t.integer :level, default: 0

      t.timestamps
    end
  end
end
