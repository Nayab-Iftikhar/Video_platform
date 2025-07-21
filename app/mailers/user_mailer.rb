class UserMailer < ApplicationMailer
	default from: Rails.application.credentials.GMAIL_USERNAME

  def project_created(project)
    @project = project
    @client = project.client
    @project_manager = project.project_manager

    mail(to: @client.email_address, subject: "Your project #{@project.name} has been created")
  end
end
