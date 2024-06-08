class Hero < ApplicationRecord
  enum :hero_class, HERO_CLASSES
  enum :hero_type, HERO_TYPES
  enum :hero_role, HERO_ROLES
  enum :hero_style, HERO_STYLES
end
