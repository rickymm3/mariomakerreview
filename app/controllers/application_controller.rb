class ApplicationController < ActionController::Base

  include ApplicationHelper
  include CliqsHelper
  include MarioHelper
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :load_index
  before_filter :check_for_username, except: [:edit, :update]
  before_filter :get_favorites
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def render404
    render :file => File.join(Rails.root, 'public', '404.html'), :status => 404, :layout => false
    return true
  end

  def get_favorites
    if user_signed_in?
      @favorites = Favorite.where(user_id:current_user.id,active:true)
    end
  end

  protected

  def check_for_username
    if current_user
      unless current_user.username?
        redirect_to edit_user_registration_path
      end
    end
  end

  def load_index
    @top_cliq = Cliq.where(is_main:true).first
    @cliq = @top_cliq
    @categories = Cliq.where(is_category: true)
    unless session[:cliq_ids]
      session[:cliq_ids] ||= Set.new
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit :username, :email, :password, :password_confirmation
    end
  end

  def edit_permissions(id, tr)
    if id && tr && current_user
      if tr == 'reply'
          x = Reply.find(id)
      elsif tr == 'topic'
          x = Topic.friendly.find(id)
      end
    end
    unless current_user.id == x.user_id
      redirect_to "/pages/not_authorized"
    end
  end

end
