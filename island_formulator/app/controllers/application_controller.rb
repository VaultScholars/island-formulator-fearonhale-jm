class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

    helper_method :current_user

  private

  def current_user
    # Look for a user ID in the browser session, then find that user in the DB
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def authenticate_user!
    # If no one is logged in, send them to the login page
    if current_user.nil?
      redirect_to new_session_path, alert: "You must be signed in to do that."
    end
  end
end
