# These methods can be called from *any* view in the app.
module ApplicationHelper
  include Pagy::Frontend

  def flash_class(level)
    case level
    when 'notice', 'success'
      'alert alert-success alert-dismissible'
    when 'info'
      'alert alert-info alert-dismissible'
    when 'warning'
      'alert alert-warning alert-dismissible'
    when 'alert', 'error'
      'alert alert-danger alert-dismissible'
    end
  end
end
