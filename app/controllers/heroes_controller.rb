# frozen_string_literal: false

class HeroesController < ApplicationController
  def index
    update_session_filter_params
    assign_filter_instance_variable

    @heroes = Hero.order(@order_by.to_sym => :desc)
    @heroes = @heroes.where(hero_type: @hero_type) if @hero_type.nonzero?
    @heroes = @heroes.where(hero_style: @hero_style) if @hero_style.nonzero?
    @heroes = @heroes.where(hero_role: @hero_role) if @hero_role.nonzero?
  end

  def show
    @hero = set_hero
  end

  def edit
    @hero = set_hero
  end

  def update
    if hero.update(hero_params)
      redirect_to heroes_path, success: 'Hero updated'
    else
      render :edit, error: hero.errors.full_messages.first
    end
  end

  private

  def update_session_filter_params
    session['hero'] ||= {}

    update_hero_order_by_session_filter_params
    update_hero_type_session_filter_params
    update_hero_style_session_filter_params
    update_hero_role_session_filter_params
  end

  def update_hero_order_by_session_filter_params
    return if params[:order_by].blank?

    session['hero']['order_by'] = params[:order_by]
  end

  def update_hero_type_session_filter_params
    return if params[:hero_type].blank?

    session['hero']['hero_type'] =
      Hero.valid_hero_type(params[:hero_type])
  end

  def update_hero_style_session_filter_params
    return if params[:hero_style].blank?

    session['hero']['hero_style'] =
      Hero.valid_hero_style(params[:hero_style])
  end

  def update_hero_role_session_filter_params
    return if params[:hero_role].blank?

    session['hero']['hero_role'] =
      Hero.valid_hero_role(params[:hero_role])
  end

  def assign_filter_instance_variable
    @order_by = session['hero']['order_by'] || :combat_power
    @hero_type = session['hero']['hero_type'].to_i
    @hero_style = session['hero']['hero_style'].to_i
    @hero_role = session['hero']['hero_role'].to_i
  end

  def hero
    @hero ||= set_hero
  end

  def set_hero
    Hero.find(params[:id])
  end

  def hero_params
    params.require(:hero).permit(HERO_PARAMS)
  end
end
