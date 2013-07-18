module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title='')
    base_title = APP_CONFIG['site_name']
    if (page_title.empty?)
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def format_text(content)
    simple_format(auto_link(content))
  end
end