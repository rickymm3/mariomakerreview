class MariomakerController < ApplicationController

  def index
  end

  def new
    @mariolevel = MarioLevel.new
  end


end