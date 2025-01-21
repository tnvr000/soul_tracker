class PagesController < ApplicationController
  allow_unauthenticated_access
  before_action :resume_session

  def index
    @next_hero_to_breakthrough = Hero.next_hero_to_breakthrough
  end
end
