class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update ]

  def index
    @projects = policy_scope(Project)
  end

  def new
    @project = Project.new
    authorize @project
    @video_types = VideoType.all
  end

  def create
    @project = Current.user.projects.build(project_params)
    @project.status = :in_progress
    @project.project_manager = User.project_manager.sample # randomly assign a PM

    authorize @project

    if @project.save
      params[:video_type_ids].each do |vid|
        @project.videos.create(video_type_id: vid)
      end

      # NotifyProjectManagerJob.perform_later(@project.id)
      redirect_to projects_path, notice: "Project ordered successfully!"
    else
      flash.now[:alert] = "Something went wrong."
      render :new
    end
  end

  private
    def set_project
      @project = Project.find(params.expect(:id))
    end

    def project_params
      params.require(:project).permit(:name, :footage_url, :paid_at)
    end

    def require_client
      redirect_to root_path unless current_user.client?
    end
end
