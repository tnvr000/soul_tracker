# frozen_string_literal: false

class HeroesController < ApplicationController
  def index
    @heroes = Hero.all.order(combat_power: :desc)
    @heroes = @heroes.where(hero_type: params[:hero_type]) if params[:hero_type].present?
    @heroes = @heroes.where(hero_role: params[:hero_role]) if params[:hero_role].present?
    @heroes = @heroes.where(hero_style: params[:hero_style]) if params[:hero_style].present?
  end
end
