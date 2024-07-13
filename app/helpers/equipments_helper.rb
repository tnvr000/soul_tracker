module EquipmentsHelper
  def equipment_class(equipment)
    str = equipment.equipment_class
    return str if equipment.equipment_class_level.zero?

    str << '*' * equipment.equipment_class_level
  end
end
