require "csv"

class Hero < ApplicationRecord
  self.table_name = "heroes"

  enum :hero_class, { normal: 1, rare: 2, epic: 3 }
  enum :hero_type, { human: 1, horde: 2, elf: 3, undead: 4, light: 5, dark: 6 }
  enum :hero_style, { strength: 1, agility: 2, intelligence: 3 }
  enum :hero_role, { tank: 1, dealer: 2, supporter: 3, healer: 4 }

  belongs_to :user, optional: true

  validates :stars, comparison: {
    greater_than_or_equal_to: MINIMUM_NUMBER_OF_STARS,
    less_than_or_equal_to: MAXIMUM_NUMBER_OF_STARS
  }
  validates_uniqueness_of :unique_key
  before_create :set_unique_key
  before_save -> { self.count_offset %= HEROES_REQUIRED_FOR_8_STARS_HERO }

  CSV_HEADERS = {
    name: "Name", hero_class: "Class", hero_type: "Type", level: "Level", stars: "Stars",
    hero_role: "Role", hero_style: "Style", combat_power: "Combat Power", hit_point: "Hit Point",
    defense: "Defense", attack: "Attack", speed: "Speed", count: "Count", unique_key: "Key"
  }

  def set_unique_key
    return if self.unique_key.present?

    self.unique_key = SecureRandom.hex(10)
  end

  class << self
    def next_hero_to_breakthrough
      limit_level = self.select(:level)
        .where(user_id: Current.user&.id)
        .order(level: :desc).distinct
        .offset(1).limit(1)
        .first&.level.to_i

      self.where(level: limit_level).order(combat_power: :desc).first
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
        hero = Hero.find_by(unique_key: row[CSV_HEADERS[:unique_key]], user_id: Current.user&.id)
        hero = Hero.new(user_id: Current.user&.id) if hero.blank?

        hero.assign_attributes(
          name: row[CSV_HEADERS[:name]],
          hero_class: row[CSV_HEADERS[:hero_class]],
          hero_type: row[CSV_HEADERS[:hero_type]],
          level: row[CSV_HEADERS[:level]],
          stars: row[CSV_HEADERS[:stars]],
          hero_role: row[CSV_HEADERS[:hero_role]],
          hero_style: row[CSV_HEADERS[:hero_style]],
          combat_power: row[CSV_HEADERS[:combat_power]],
          hit_point: row[CSV_HEADERS[:hit_point]],
          defense: row[CSV_HEADERS[:defense]],
          attack: row[CSV_HEADERS[:attack]],
          speed: row[CSV_HEADERS[:speed]],
          count: row[CSV_HEADERS[:count]],
        )

        hero.save
      end
    end
  end
end
