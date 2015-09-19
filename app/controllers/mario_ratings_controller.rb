class MarioRatingsController < ApplicationController
  layout 'mariomaker'

  def index
  end

  def new
    @mario_level = MarioLevel.find(params[:id])
    if MarioRating.where(user_id: current_user.id, mario_level_id: params[:id]).exists?
      @rated = true
    else
      @rating = MarioRating.new
    end
  end

  def create
    @rating = MarioRating.new(mario_rating_params)
    @rating.user_id = current_user.id
    @rating.mario_level_id = params[:id]
    @mario_level = MarioLevel.find(params[:id])
    update_mario_level_rank(@mario_level, mario_rating_params)
    respond_to do |format|
      if @rating.save
        format.html { redirect_to @mario_level, notice: 'Your level was added!' }
        format.json { render action: 'show', status: :created, location: @rating }
      else
        format.html { render action: 'new' }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def mario_rating_params
    params.require(:mario_rating).permit(:fun, :puzzle, :difficulty, :overall)
  end

end