class AddUniqueKeyToEquipments < ActiveRecord::Migration[7.1]
  def change
    add_column :equipment, :unique_key, :string, null: false
    add_index :equipment, :unique_key, unique: true
  end
end
