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

  def roles
    {
        1 => "super_admin",
        2 => "admin",
        3 => "board_mod"
    }
  end

end