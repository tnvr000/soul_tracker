class AddCountOffserToHeroes < ActiveRecord::Migration[8.0]
  def change
    add_column :heroes, :count_offset, :integer, default: 0
  end
end
