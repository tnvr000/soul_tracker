class PagesController < ApplicationController
  def index
    @next_hero_to_breakthrough = Hero.next_hero_to_breakthrough
  end
end
