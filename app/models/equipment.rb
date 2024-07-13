class Equipment < ApplicationRecord
  enum :equipment_style, { strength: 1, agility: 2, intelligence: 3 }
  enum :equipment_type, { weapon: 1, headwear: 2, bodywear: 3, footwear: 4 }
  enum :equipment_class, { normal: 1, advanced: 2, rare: 3, epic: 4, legendary: 4, mythic: 5 }
end
