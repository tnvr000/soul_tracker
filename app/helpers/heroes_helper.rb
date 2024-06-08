module HeroesHelper
  def hero_class_options
    HERO_CLASSES.map { |hero_class, _index| [hero_class.to_s.titlecase, hero_class.to_s] }
  end

  def hero_type_options
    HERO_TYPES.map { |hero_type, _index| [hero_type.to_s.titlecase, hero_type.to_s] }
  end

  def hero_role_options
    HERO_ROLES.map { |hero_role, _index| [hero_role.to_s.titlecase, hero_role.to_s] }
  end

  def hero_style_options
    HERO_STYLES.map { |hero_style, _index| [hero_style.to_s.titlecase, hero_style.to_s] }
  end
end
