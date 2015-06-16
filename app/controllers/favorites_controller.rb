class FavoritesController < ApplicationController

  def update
    @cliq = Cliq.find_by_slug(params[:id])
    favorite = Favorite.where(user_id: current_user.id, cliq_id: @cliq.id).first_or_initialize
    favorite.update_attributes(active:!favorite.active)
    @active = favorite.active
    @cliq_id = @cliq.id
  end

end
