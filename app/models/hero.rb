class Hero < ApplicationRecord
  enum :hero_class, { normal: 1, rare: 2, epic: 3 }
  enum :hero_type, { human: 1, horde: 2, elf: 3, undead: 4, light: 5, dark: 6 }
  enum :hero_role, { tank: 1, dealer: 2, supporter: 3, healer: 4 }
  enum :hero_style, { strength: 1, agility: 2, intelligence: 3 }
end
