class AddCountToHeroes < ActiveRecord::Migration[7.1]
  def change
    add_column :heros, :count, :integer, :default => 1
  end
end
