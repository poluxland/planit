class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :share, :share_ref]

  def home
  end

  def share
  end

  def share_ref
    code = code_params[:code].to_i
    @trip = Trip.find_by(code: code)

    session[:code] = code
    authorize @trip

    @task = Task.new
    @subtask = Subtask.new

    @markers = [
      {
        lat: @trip.latitude,
        lng: @trip.longitude,
        infoWindow: render_to_string(partial: "trips/info_window", locals: { trip: @trip })
      }
    ]

    render "trips/show"
  end

  private

def code_params
    params.permit(:code)
  end
end
