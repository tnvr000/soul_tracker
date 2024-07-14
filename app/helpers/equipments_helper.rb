module EquipmentsHelper
  def submit_url
    @equipment.persisted? ? equipment_path(@equipment) : equipments_path
  end

  def submit_method
    @equipment.persisted? ? :patch : :post
  end

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
      ['Select Class Level', 0],
      ['*', 1],
      ['**', 2],
      ['***', 3]
    ]
  end
end
