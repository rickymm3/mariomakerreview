class Admin::ReportsController < ApplicationController

  before_filter :require_admin
  layout "admin"

  def index
    @reported_threads = Topic.all.where('reports >= 1')
  end

  protected

  def require_admin
    unless current_user.try(:is_admin?)
      render404 and return false
    end
  end

end
