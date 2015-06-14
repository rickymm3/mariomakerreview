class FavoritesController < ApplicationController

  def update
    favorite = Favorite.where(user_id: current_user.id, cliq_id: params[:id]).first_or_initialize
    favorite.update_attributes(active:!favorite.active)
    @active = favorite.active
    @cliq_id = params[:id]
  end

end
