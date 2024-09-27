module EquipmentsHelper
  def equipment_class(equipment)
    str = equipment.equipment_class
    return str if equipment.equipment_class_level.zero?

    str + '*' * equipment.equipment_class_level
  end

  def equipment_type_form_options
    Equipment
      .equipment_types
      .map { |equipment_type, _index| [equipment_type.to_s.titlecase, equipment_type.to_s] }
  end

  def equipment_style_form_options
    Equipment
      .equipment_styles
      .map { |equipment_style, _index| [equipment_style.to_s.titlecase, equipment_style.to_s] }
  end

  def equipment_class_form_options
    Equipment
      .equipment_classes
      .map { |equipment_class, _index| [equipment_class.to_s.titlecase, equipment_class.to_s] }
  end

  def equipmetn_class_level_form_options
    [
      ['No Stars', 0],
      ['*', 1],
      ['**', 2],
      ['***', 3]
    ]
  end

  def equipment_style_filter_options
    Equipment
      .equipment_styles
      .map { |equipment_style, value| [equipment_style.to_s.titlecase, value, @equipment_style == value] }
      .unshift(['All Styles', 0, @equipment_style.zero?])
  end

  def equipment_type_filter_options
    Equipment
      .equipment_types
      .map { |equipment_type, value| [equipment_type.to_s.titlecase, value, @equipment_type == value] }
      .unshift(['All Types', 0, @equipment_type.zero?])
  end

  def equipment_class_filter_options
    Equipment
      .equipment_classes
      .map { |equipment_class, value| [equipment_class.to_s.titlecase, value, @equipment_class == value] }
      .unshift(['All Classes', 0, @equipment_class.zero?])
  end

  def equipment_class_level_filter_options
    [
      ['All Class Level', -1, @equipment_class_level == -1],
      ['-', 0, @equipment_class_level.zero?],
      ['*', 1, @equipment_class_level == 1],
      ['**', 2, @equipment_class_level == 2],
      ['***', 3, @equipment_class_level == 3]
    ]
  end
end
