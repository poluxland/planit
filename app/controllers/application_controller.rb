class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  include Pundit

  # Pundit: white-list approach.
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?


  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(root_path)
  end

  def add_temporary_trip
    unless session["temporary_trip"].nil?
      flash[:alert] = "A trip was successfully linked to your account"
      @trip = Trip.find(session["temporary_trip"]) rescue nil
      unless @trip == nil
        @trip.session = false
        @trip.user = current_user
        @trip.save
      end
    end
  end

  def after_sign_in_path_for(resource)
    add_temporary_trip
    stored_location_for(resource) || trips_path
  end

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  protected

   def configure_permitted_parameters
      # For additional fields in app/views/devise/registrations/new.html.erb
      devise_parameter_sanitizer.permit(:sign_up, keys: [:avatar])

      # For additional in app/views/devise/registrations/edit.html.erb
      devise_parameter_sanitizer.permit(:account_update, keys: [:avatar])
    end
end
