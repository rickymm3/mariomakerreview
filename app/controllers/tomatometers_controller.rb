class TomatometersController < ApplicationController

  def index
    @response =
        HTTParty.get("http://api.rottentomatoes.com/api/public/v1.0/lists/movies/upcoming.json?apikey=[kw9dr9ackqyppskyn4msdnmv]")
  end


end