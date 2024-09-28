require 'csv'

class Equipment < ApplicationRecord
  enum :equipment_style, { strength: 1, agility: 2, intelligence: 3 }
  enum :equipment_type, { weapon: 1, headwear: 2, bodywear: 3, footwear: 4 }
  enum :equipment_class, { normal: 1, advanced: 2, rare: 3, epic: 4, legendary: 5, mythic: 6 }

  before_create :set_unique_key

  HEADERS = { 
    name: 'Name', equipment_type: 'Type', equipment_style: 'Style', equipment_class: 'Class',
    equipment_class_level: 'Class level', level: 'Level', unique_key: 'Key'
  }

  def set_unique_key
    self.unique_key = SecureRandom.hex(10)
  end

  class << self
    def valid_equipment_type(equipment_type)
      return 0 unless equipment_type.to_i.in?(equipment_types.values)

      equipment_type.to_i
    end

    def valid_equipment_style(equipment_style)
      return 0 unless equipment_style.to_i.in?(equipment_styles.values)

      equipment_style.to_i
    end

    def valid_equipment_class(equipment_class)
      return 0 unless equipment_class.to_i.in?(equipment_classes.values)

      equipment_class.to_i
    end

    def valid_equipment_class_level(equipment_class_level)
      return -1 unless equipment_class_level.to_i.in?([0, 1, 2, 3])

      equipment_class_level.to_i
    end

    def to_csv
      CSV.generate(headers: true) do |csv|
        csv << HEADERS.values

        all.each do |equipment|
          csv << HEADERS.keys.map { |attr| equipment.send(attr) }
        end
      end
    end

    def import(file)
      CSV.foreach(file, headers: true) do |row|
        equipment = Equipment.find_by(unique_key: row[HEADERS[:unique_key]])
        equipment = Equipment.new if equipment.blank?

        equipment.assign_attributes(
          name: row[HEADERS[:name]],
          equipment_type: row[HEADERS[:equipment_type]],
          equipment_style: row[HEADERS[:equipment_style]],
          equipment_class: row[HEADERS[:equipment_class]],
          equipment_class_level: row[HEADERS[:equipment_class_level]],
          level: row[HEADERS[:level]],
        )

        equipment.save
      end
    end
  end
end
