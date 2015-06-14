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
      "http://graph.facebook.com/#{uid}/picture"
    else
      ""
    end
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
    cliq.ancestry.split("/").last.to_i
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

end