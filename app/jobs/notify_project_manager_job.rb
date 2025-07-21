class NotifyProjectManagerJob < ApplicationJob
  queue_as :default

  def perform(project_id)
    project = Project.find(project_id)

    project_manager = project.project_manager

    UserMailer.project_created(project).deliver_later
  end
end
