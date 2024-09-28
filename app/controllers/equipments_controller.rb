class EquipmentsController < ApplicationController
  def index
    update_session_filter_params
    assign_filter_instance_variable

    @equipments = Equipment.order(@order_by.to_sym => :desc)
    @equipments = @equipments.where(equipment_type: @equipment_type) if @equipment_type.nonzero?
    @equipments = @equipments.where(equipment_style: @equipment_style) if @equipment_style.nonzero?
    @equipments = @equipments.where(equipment_class: @equipment_class) if @equipment_class.nonzero?
    @equipments = @equipments.where(equipment_class_level: @equipment_class_level) if @equipment_class_level >= 0

    respond_to do |format|
      format.html

      format.csv { send_data @equipments.to_csv, filename: "equipments_#{Time.now.to_i}.csv" }
    end
  end

  def new
    @equipment = Equipment.new
  end

  def create
    @equipment = Equipment.new(equipment_params)

    if equipment.save
      redirect_to(equipments_path)
    else
      render :new
    end
  end

  def show
    @equipment = set_equipment
  end

  def duplicate
    new_equipment = equipment.dup
    new_equipment.save
    redirect_to equipments_path
  end

  def edit
    @equipment = set_equipment
  end

  def update
    equipment.assign_attributes(equipment_params)

    if equipment.save
      redirect_to(equipments_path)
    else
      render :edit
    end
  end

  def destroy
    equipment.destroy

    redirect_to equipments_path
  end

  private

  def update_session_filter_params
    session['equipment'] ||= {}

    update_equipment_order_by_session_filter_params
    update_equipment_type_session_filter_params
    update_equipment_style_session_filter_params
    update_equipment_class_session_filter_params
    update_equipment_class_level_session_filter_params
  end

  def update_equipment_order_by_session_filter_params
    return if params[:order_by].blank?

    session['equipment']['order_by'] = params[:order_by]
  end

  def update_equipment_type_session_filter_params
    return if params[:equipment_type].blank?

    session['equipment']['equipment_type'] =
      Equipment.valid_equipment_type(params[:equipment_type])
  end

  def update_equipment_style_session_filter_params
    return if params[:equipment_style].blank?

    session['equipment']['equipment_style'] =
      Equipment.valid_equipment_style(params[:equipment_style])
  end

  def update_equipment_class_session_filter_params
    return if params[:equipment_class].blank?

    session['equipment']['equipment_class'] =
      Equipment.valid_equipment_class(params[:equipment_class])
  end

  def update_equipment_class_level_session_filter_params
    return if params[:equipment_class_level].blank?

    session['equipment']['equipment_class_level'] =
      Equipment.valid_equipment_class_level(params[:equipment_class_level])
  end

  def assign_filter_instance_variable
    @order_by = session['equipment']['order_by'] || :equipment_class
    @equipment_type = session['equipment']['equipment_type'].to_i
    @equipment_style = session['equipment']['equipment_style'].to_i
    @equipment_class = session['equipment']['equipment_class'].to_i
    @equipment_class_level = session['equipment']['equipment_class_level'] || -1
  end

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
