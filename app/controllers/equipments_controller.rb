class EquipmentsController < ApplicationController
  def index
    @equipments = Equipment.all
  end

  def show
    @equipment = set_equipment
  end

  private

  def equipment
    @equipment || set_equipment
  end

  def set_equipment
    Equipment.find(params[:id])
  end
end
