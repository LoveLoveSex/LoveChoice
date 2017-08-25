module ApplicationHelper
  def admin?
    if current_user.administrator?
      return true
    else
      return false
    end
  end
end
