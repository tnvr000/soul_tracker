class HeroesController < ApplicationController
  allow_unauthenticated_access
  before_action :resume_session

  def index
    update_session_filter_params
    assign_filter_instance_variables

    @heroes = Hero.where(user_id: Current.user&.id)
    @heroes = @heroes.order(@order_by.to_sym => :desc)
    @heroes = @heroes.where(hero_class: :epic)
    @heroes = @heroes.where(hero_type: @hero_type) if @hero_type.nonzero?
    @heroes = @heroes.where(hero_style: @hero_style) if @hero_style.nonzero?
    @heroes = @heroes.where(hero_role: @hero_role) if @hero_role.nonzero?

    respond_to do |format|
      format.html

      format.csv { send_data @heroes.to_csv, filename: "heroes_battle_stats_#{Time.now.to_i}.csv" }
    end
  end

  def new
    @hero = Hero.new
  end

  def create
    @hero = Hero.new(user_id: Current.user&.id)
    hero.assign_attributes(hero_params)

    respond_to do |format|
      format.html do
        if hero.save
          redirect_to params[:hero][:navigate_to], notice: "Hero Created"
        else
          flash.now[:alert] = first_error(hero)
          render :new, status: :unprocessable_entity
        end
      end # response for html format
    end
  end

  def show
    @hero = set_hero
  end

  def edit
    @hero = set_hero
  end

  def update
    hero.assign_attributes(hero_params)

    respond_to do |format|
      format.html do
        if hero.save
          redirect_to params[:hero][:navigate_to], notice: "Hero Updated"
        else
          flash.now[:alert] = first_error(hero)
          render :edit, status: :unprocessable_entity
        end
      end # response for html format
    end
  end

  def destroy
    hero.destroy

    redirect_to heroes_path, alert: "Hero Deleted"
  end

  def statistics
    update_statistics_session_filter_params
    assign_statistics_filter_instance_variables

    @heroes = Hero.where(user_id: Current.user&.id).order(count: :desc)
    @heroes = @heroes.where(hero_type: @hero_type) if @hero_type.nonzero?
    @heroes = @heroes.where(hero_class: @hero_class) if @hero_class.nonzero?

    respond_to do |format|
      format.html

      format.csv { send_data @heroes.to_csv, filename: "heroes_statistics_#{Time.now.to_i}.csv" }
    end
  end

  def adjust_stat
    adjust_stat_of(adjustable_attribute)
    hero.reload
    @adjusted_partial = set_adjusted_partial

    respond_to do |format|
      format.turbo_stream
    end
  end

  def importer; end

  def import
    file = File.open(params[:file])
    Hero.import(file)

    redirect_to heroes_path, notice: "Heroes Imported"
  end

  private

  def hero
    @hero ||= set_hero
  end

  def set_hero
    Hero.find_by(id: params[:id], user_id: Current.user&.id)
  end

  def hero_params
    params.require(:hero).permit(HERO_PARAMS)
  end

  # load and update sessions for index action
  def update_session_filter_params
    session["hero"] ||= {}

    update_hero_order_by_session_filter_params
    update_hero_type_session_filter_params
    update_hero_style_session_filter_params
    update_hero_role_session_filter_params
  end

  def update_hero_order_by_session_filter_params
    return if params[:order_by].blank?

    session["hero"]["order_by"] = params[:order_by]
  end

  def update_hero_type_session_filter_params
    return if params[:hero_type].blank?

    session["hero"]["hero_type"] = Hero.valid_hero_type(params[:hero_type])
  end

  def update_hero_style_session_filter_params
    return if params[:hero_style].blank?

    session["hero"]["hero_style"] = Hero.valid_hero_style(params[:hero_style])
  end

  def update_hero_role_session_filter_params
    return if params[:hero_role].blank?

    session["hero"]["hero_role"] = Hero.valid_hero_role(params[:hero_role])
  end

  def assign_filter_instance_variables
    @order_by = session["hero"]["order_by"] || :combat_power
    @hero_type = session["hero"]["hero_type"].to_i
    @hero_style = session["hero"]["hero_style"].to_i
    @hero_role = session["hero"]["hero_role"].to_i
  end

  # load and update sessions for statistics action
  def update_statistics_session_filter_params
    session["hero_statistics"] ||= {}

    update_statistics_hero_type_session_filter_params
    update_statistics_hero_class_session_filter_params
  end

  def update_statistics_hero_type_session_filter_params
    return if params[:hero_type].blank?

    session["hero_statistics"]["hero_type"] = Hero.valid_hero_type(params[:hero_type])
  end

  def update_statistics_hero_class_session_filter_params
    return if params[:hero_class].blank?

    session["hero_statistics"]["hero_class"] = Hero.valid_hero_class(params[:hero_class])
  end

  def assign_statistics_filter_instance_variables
    @hero_type = session["hero_statistics"]["hero_type"].to_i
    @hero_class = session["hero_statistics"]["hero_class"].to_i
  end

  # adjust stats
  def adjustable_attribute
    return nil unless [ "stars", "count" ].include?(params[:attribute])

    params[:attribute].downcase
  end

  def adjust_stat_of(attribute)
    return if attribute.blank?

    case params[:direction]
    when "increment"
      hero.update(attribute => hero[attribute] + 1)
    when "decrement"
      hero.update(attribute => hero[attribute] - 1)
    end
  end

  def set_adjusted_partial
    case adjustable_attribute
    when "stars"
      "battle_stats"
    when "count"
      "frequency_stats"
    end
  end
end
