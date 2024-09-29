class AddUniqueKeyToHeroes < ActiveRecord::Migration[7.1]
  def change
    add_column :heros, :unique_key, :string, null: false
    add_index :heros, :unique_key
  end
end
