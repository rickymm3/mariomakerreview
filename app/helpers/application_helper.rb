module ApplicationHelper

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = (column == sort_column) ? "current #{sort_direction}" : nil
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to title, { :sort => column, :direction => direction }, { :class => css_class }
  end

  def full_ancestry(cliq)
    cliq.ancestors << cliq
  end

  def facebook_image(uid)
    if uid
      image_tag("http://graph.facebook.com/#{uid}/picture")
    else
      render "shared/no_avatar"
    end
  end

  def font_awesome(icon)
    "<i class='fa fa-#{icon}'></i>".html_safe
  end

  def report_reasons
    {
        1 => "flaming",
        2 => "trolling",
        3 => "inappropriate",
        4 => "off-topic"
    }
  end

  def get_parent_id(cliq)
    cliq.ancestry.split("/").last.to_i unless !@cliq || !@cliq.ancestry?
  end

  def get_category_id(cliq)
    cliq.ancestry.split("/").second.to_i unless !@cliq || !@cliq.ancestry?
  end

  # def nav_link(text, path)
  #   options = current_page?(path) ? { class: "active" } : {}
  #   content_tag(:li, options) do
  #     link_to text, path
  #   end
  # end

  def check_if_favorite(cliq)
    if current_user.favorites.where(active:true).select(:cliq_id).exists?(cliq_id: cliq.id)
      "<i class='fa fa-star'></i>"
    else
      "<i class='fa fa-star-o'></i>"
    end
  end

  def check_if_bookmarked(topic)
    if current_user.bookmarks.where(done:false).select(:topic_id).exists?(topic_id: topic.id)
      "<i class='fa fa-bookmark icon-active'></i>"
    else
      "<i class='fa fa-bookmark'></i>"
    end
  end

  def controller?(*controller)
    controller.include?(params[:controller])
  end

  def action?(*action)
    action.include?(params[:action])
  end

  def get_background_color(cliq)
    if cliq.ancestors.count < 2
      cliq.color
    else
      cliq.ancestors[1].color
    end
  end

  def category_is_active?(cliq)
    cliq.id == get_category_id(@cliq) || cliq.id == @cliq.id
  end

  def get_interest(exp)
    if exp < 10
      "<i class='fa fa-fire new'></i>".html_safe
    elsif exp < 25
      "<i class='fa fa-fire warm'></i>".html_safe
    elsif exp < 100
      "<i class='fa fa-fire hot'></i>".html_safe
    elsif exp < 500
      "<i class='fa fa-fire hottest'></i>".html_safe
    end
  end

end