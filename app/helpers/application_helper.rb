module ApplicationHelper
  def page_title(title = '', admin: false)
    base_title = admin ? 'RUNTEQ BOARD APP(管理画面)' : 'RUNTEQ BOARD APP'
    title.present? ? "#{title} | #{base_title}" : base_title
  end

  def admin_title(title)
    page_title(title, admin: true)
  end
end
