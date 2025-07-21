module ProjectsHelper
  def formatted_date(date)
    date.strftime("%Y-%m-%d")
  end

  def project_counterpart_label
    if Current.user.client?
      "PM"
    elsif Current.user.project_manager?
      "Client"
    else
      "User"
    end
  end

  def project_counterpart_user(project)
    return unless project

    if Current.user.client?
      project.project_manager
    elsif Current.user.project_manager?
      project.client
    end
  end

  def status_badge_class(status)
    {
      "pending" => "bg-secondary",
      "in_progress" => "bg-warning text-dark",
      "completed" => "bg-success"
    }[status] || "bg-light"
  end
end
