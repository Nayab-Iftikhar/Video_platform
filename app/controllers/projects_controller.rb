class ProjectsController < ApplicationController
  # before_action :set_project

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
    @project.project_manager = User.project_manager.sample
  
    video_type_ids = params[:video_type_ids] || []
  
    if video_type_ids.empty?
      flash[:alert] = "Please select at least one video type."
      render :new and return
    end
  
    authorize @project
  
    ActiveRecord::Base.transaction do
      if @project.save
        video_type_ids.each do |vid|
          unless @project.videos.create!(video_type_id: vid, name: "video for project #{@project.id}")
            raise ActiveRecord::Rollback, "Video creation failed"
          end
        end
        NotifyProjectManagerJob.perform_later(@project.id)
  
        redirect_to projects_path, notice: "Project ordered successfully!"
      else
        flash.now[:alert] = "Something went wrong."
        render :new
        raise ActiveRecord::Rollback
      end
    end
  rescue ActiveRecord::Rollback
    flash.now[:alert] = "There was an error processing your request. Please try again."
    render :new
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
