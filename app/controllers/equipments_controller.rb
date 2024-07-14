class EquipmentsController < ApplicationController
  def index
    @equipments = Equipment.all
  end

  def new
    @equipment = Equipment.new
  end

  def create
    @equipment = Equipment.new(equipment_params)

    if equipment.save
      redirect_to(equipment_path(equipment))
    else
      render :new
    end
  end

  def show
    @equipment = set_equipment
  end

  private

  def equipment_params
    params.require(:equipment).permit(EQUIPMENT_PARAMS)
  end

  def equipment
    @equipment ||= set_equipment
  end

  def set_equipment
    Equipment.find(params[:id])
  end
end
