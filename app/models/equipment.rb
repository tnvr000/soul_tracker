class Equipment < ApplicationRecord
  enum :equipment_style, { strength: 1, agility: 2, intelligence: 3 }
  enum :equipment_type, { weapon: 1, headwear: 2, bodywear: 3, footwear: 4 }
  enum :equipment_class, { normal: 1, advanced: 2, rare: 3, epic: 4, legendary: 5, mythic: 6 }

  class << self
    def valid_equipment_style(equipment_style)
      return 0 unless equipment_style.to_i.in?(equipment_styles.values)

      equipment_style.to_i
    end

    def valid_equipment_type(equipment_type)
      return 0 unless equipment_type.to_i.in?(equipment_types.values)

      equipment_type.to_i
    end

    def valid_equipment_class(equipment_class)
      return 0 unless equipment_class.to_i.in?(equipment_classes.values)

      equipment_class.to_i
    end

    def valid_equipment_class_level(equipment_class_level)
      return -1 unless equipment_class_level.to_i.in?([0, 1, 2, 3])

      equipment_class_level.to_i
    end
  end
end
