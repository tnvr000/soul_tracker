require 'csv'

class Hero < ApplicationRecord
  enum :hero_class, { normal: 1, rare: 2, epic: 3 }
  enum :hero_type, { human: 1, horde: 2, elf: 3, undead: 4, light: 5, dark: 6 }
  enum :hero_style, { strength: 1, agility: 2, intelligence: 3 }
  enum :hero_role, { tank: 1, dealer: 2, supporter: 3, healer: 4 }

  before_create :set_unique_key

  CSV_HEADERS = {
    name: 'Name', hero_class: 'Class', hero_type: 'Type', level: 'Level', stars: 'Stars',
    hero_role: 'Role', hero_style: 'Style', combat_power: 'Combat Power', hit_point: 'Hit Point',
    defence: 'Defence', attack: 'Attack', speed: 'Speed', count: 'Count', unique_key: 'Key'
  }

  def set_unique_key
    self.unique_key = SecureRandom.hex(10)
  end

  class << self
    def next_hero_to_breakthrough
      limit_level = self.select(:level)
        .order(level: :desc).distinct
        .offset(1).limit(1)
        .first&.level.to_i

      where(level: limit_level).order(combat_power: :desc).first
    end

    def valid_hero_class(hero_class)
      return 0 unless hero_class.to_i.in?(hero_classes.values)

      hero_class.to_i
    end

    def valid_hero_type(hero_type)
      return 0 unless hero_type.to_i.in?(hero_types.values)

      hero_type.to_i
    end

    def valid_hero_style(hero_style)
      return 0 unless hero_style.to_i.in?(hero_styles.values)

      hero_style.to_i
    end

    def valid_hero_role(hero_role)
      return 0 unless hero_role.to_i.in?(hero_roles.values)

      hero_role.to_i
    end

    def to_csv
      CSV.generate(headers: true) do |csv|
        csv << CSV_HEADERS.values

        all.each do |hero|
          csv << CSV_HEADERS.keys.map { |attr| hero.send(attr) }
        end
      end
    end

    def import(file)
      CSV.foreach(file, headers: true) do |row|
        hero = Hero.find_or_initialize_by(name: row[CSV_HEADERS[:name]])

        hero.assign_attributes(
          hero_class: row[CSV_HEADERS[:hero_class]],
          hero_type: row[CSV_HEADERS[:hero_type]],
          level: row[CSV_HEADERS[:level]],
          stars: row[CSV_HEADERS[:stars]],
          hero_role: row[CSV_HEADERS[:hero_role]],
          hero_style: row[CSV_HEADERS[:hero_style]],
          combat_power: row[CSV_HEADERS[:combat_power]],
          hit_point: row[CSV_HEADERS[:hit_point]],
          defence: row[CSV_HEADERS[:defence]],
          attack: row[CSV_HEADERS[:attack]],
          speed: row[CSV_HEADERS[:speed]],
          count: row[CSV_HEADERS[:count]],
        )

        hero.save
      end
    end
  end
end
