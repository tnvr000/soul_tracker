class Hero < ApplicationRecord
  enum :hero_class, { normal: 1, rare: 2, epic: 3 }
  enum :hero_type, { human: 1, horde: 2, elf: 3, undead: 4, light: 5, dark: 6 }
  enum :hero_style, { strength: 1, agility: 2, intelligence: 3 }
  enum :hero_role, { tank: 1, dealer: 2, supporter: 3, healer: 4 }

  class << self
    def next_hero_to_breakthrough
      limit_level = self
        .select(:level)
        .order(level: :desc)
        .distinct.offset(1)
        .limit(1)
        .first
        .level

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
  end
end
