class ProjectPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      if @user.client?
        @scope.where(client: user)
      elsif @user.project_manager?
        @scope.where(project_manager: user)
      end
    end
  end
  
  def new?
    user.client?
  end

  def create?
    new?    
  end
end
