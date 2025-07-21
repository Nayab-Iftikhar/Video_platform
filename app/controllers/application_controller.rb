class ApplicationController < ActionController::Base
  include Authentication
  include Pundit::Authorization
  allow_browser versions: :modern

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  
  private
  
  def user_not_authorized(exception)
    flash[:alert] = exception.message
    redirect_to(request.referer || root_path)
  end
  
  def pundit_user
    Current.user
  end
end
