class MariomakerController < ApplicationController
  layout 'mariomaker'

  def index
  end

  def new
    @mariolevel = MarioLevel.new
  end


end