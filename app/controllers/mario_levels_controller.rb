class MarioLevelsController < ApplicationController
  layout 'mariomaker'
  helper_method :sort_column, :sort_direction

  def index
    @levels = MarioLevel.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 5, :page => params[:page])
  end

  def new
    @mario_level = MarioLevel.new
  end

  def create
    @mario_level = MarioLevel.new(mario_level_params)
    @mario_level.user_id = current_user.id
    if @mario_level.ss_loc.present?
      check_ss_loc
    end
    respond_to do |format|
      if @mario_level.save
        format.html { redirect_to @mario_level, notice: 'Your level was added!' }
        format.json { render action: 'show', status: :created, location: @mario_level }
      else
        format.html { render action: 'new' }
        format.json { render json: @mario_level.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @mario_level = MarioLevel.find(params[:id])
    @fun = @mario_level
  end

  private

  def mario_level_params
    params.require(:mario_level).permit(:name, :description, :ss_loc, :l_category_id, :level_code)
  end

  def check_ss_loc
    ss_loc = @mario_level.ss_loc
    unless ss_loc.include? ".cloudfront.net/ss"
      @mario_level.ss_loc = nil
    end
    # https://d3esbfg30x759i.cloudfront.net/ss/WVW69iZXTIM0M9gLDJ
  end

end