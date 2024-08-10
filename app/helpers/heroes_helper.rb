module HeroesHelper
  def hero_class_form_options
    Hero
      .hero_classes
      .map { |hero_class, _index| [hero_class.to_s.titlecase, hero_class.to_s] }
  end

  def hero_type_form_options
    Hero
      .hero_types
      .map { |hero_type, _index| [hero_type.to_s.titlecase, hero_type.to_s] }
  end

  def hero_role_form_options
    Hero
      .hero_roles
      .map { |hero_role, _index| [hero_role.to_s.titlecase, hero_role.to_s] }
  end

  def hero_style_form_options
    Hero
      .hero_styles
      .map { |hero_style, _index| [hero_style.to_s.titlecase, hero_style.to_s] }
  end

  def hero_class_options
    Hero
      .hero_classes
      .map { |hero_class, value| [hero_class.to_s.titlecase, value] }
      .unshift(['All Classes', 0])
  end

  def hero_type_filter_options
    Hero
      .hero_types
      .map { |hero_type, value| [hero_type.to_s.titlecase, value, @hero_type == value] }
      .unshift(['All Types', 0, @hero_type.to_i.zero?])
  end

  def hero_role_filter_options
    Hero
      .hero_roles
      .map { |hero_role, value| [hero_role.to_s.titlecase, value, @hero_role == value] }
      .unshift(['All Roles', 0, @hero_role.to_i.zero?])
  end

  def hero_style_filter_options
    Hero
      .hero_styles
      .map { |hero_style, value| [hero_style.to_s.titlecase, value, @hero_style == value] }
      .unshift(['All Styles', 0, @hero_style.to_i.zero?])
  end

  def hero_order_filter_options
    [
      ['Combat Power', 'combat_power', @order_by == 'combat_power'],
      ['Hit Point', 'hit_point', @order_by == 'hit_point'],
      ['Defence', 'defence', @order_by == 'defence'],
      ['Attack', 'attack', @order_by == 'attack'],
      ['Speed', 'speed', @order_by == 'speed']
    ]
  end
end
