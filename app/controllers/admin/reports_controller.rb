class Admin::ReportsController < ApplicationController

  layout "admin"

  def index
    @reported_threads = Topic.all.where('reports >= 1').page(params[:page]).limit(10)
  end

end
