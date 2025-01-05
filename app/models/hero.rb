class Hero < ApplicationRecord
  self.table_name = "heroes"

  belongs_to :user
end
