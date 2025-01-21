class AddDefaultValuesToHeroesAttributes < ActiveRecord::Migration[8.0]
  def change
    change_column_default :heroes, :stars, 4
    change_column_default :heroes, :level, 0
  end
end
