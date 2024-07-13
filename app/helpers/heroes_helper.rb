module HeroesHelper
  def hero_class_options
    Hero
      .hero_classes
      .map { |hero_class, value| [hero_class.to_s.titlecase, value] }
      .unshift(['All Classes', 0])
  end

  def hero_type_options
    Hero
      .hero_types
      .map { |hero_type, value| [hero_type.to_s.titlecase, value] }
      .unshift(['All Types', 0])
  end

  def hero_role_options
    Hero
      .hero_roles
      .map { |hero_class, value| [hero_class.to_s.titlecase, value] }
      .unshift(['All Roles', 0])
  end

  def hero_style_options
    Hero
      .hero_styles
      .map { |hero_style, value| [hero_style.to_s.titlecase, value] }
      .unshift(['All Styles', 0])
  end

  def hero_order_options
    [
      ['Combat Power', 'combat_power'],
      ['Hit Point', 'hit_point'],
      ['Defence', 'defence'],
      ['Attack', 'attack'],
      ['Speed', 'speed']
    ]
  end
end
