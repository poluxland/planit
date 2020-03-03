class TripsController < ApplicationController
  before_action :authenticate_user!

  def show
    @trip = Trip.find(params[:id])
    authorize @trip
  end

  def index
    @trips = Trip.all
    @trips = policy_scope(Trip)

    @markers = @trips.map do |trip|
      {
        lat: trip.latitude,
        lng: trip.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { trip: trip })
      }
    end

  end

  def new
    @trip = Trip.new
    authorize @trip
  end

  def create
    @trip = Trip.new(trip_params)
    authorize @trip
    @trip.user = current_user if user_signed_in?
    if @trip.save
      redirect_to trip_path @trip
    else
      render :new
    end
  end

  def destroy
    @trip = Trip.find(params[:id])
    authorize @trip
    @trip.destroy
  end

  private

  def trip_params
    params.require(:trip).permit(:start_date, :end_date, :gender, :age, :origin, :purpose, :location, :name, :description )
  end
end
