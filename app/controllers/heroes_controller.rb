# frozen_string_literal: false

class HeroesController < ApplicationController
  def index
    @heroes = Hero.all.order(combat_power: :desc)
    @heroes = @heroes.where(hero_type: params[:hero_type]) if params[:hero_type].present?
    @heroes = @heroes.where(hero_role: params[:hero_role]) if params[:hero_role].present?
    @heroes = @heroes.where(hero_style: params[:hero_style]) if params[:hero_style].present?
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
