# frozen_string_literal: false

class HeroesController < ApplicationController
  def index
    @order_by = params[:order_by] || :combat_power
    @hero_type = params[:hero_type].to_i.in?(Hero.hero_types.values) ? params[:hero_type].to_i : 0
    @hero_role = params[:hero_role].to_i.in?(Hero.hero_roles.values) ? params[:hero_role].to_i : 0
    @hero_style = params[:hero_style].to_i.in?(Hero.hero_styles.values) ? params[:hero_style].to_i : 0

    @heroes = Hero.order(@order_by.to_sym => :desc)
    @heroes = @heroes.where(hero_type: @hero_type) if @hero_type.nonzero?
    @heroes = @heroes.where(hero_role: @hero_role) if @hero_role.nonzero?
    @heroes = @heroes.where(hero_style: @hero_style) if @hero_style.nonzero?
  end

  def show
    @hero = set_hero
  end

  def edit
    @hero = set_hero
  end

  def update
    if hero.update(hero_params)
      redirect_to hero_path(hero), success: 'Hero updated'
    else
      render :edit, error: hero.errors.full_messages.first
    end
  end

  private

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
