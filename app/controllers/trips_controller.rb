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

  def edit
    @trip = Trip.find(params[:id])
    authorize @trip
  end

  def update
    @trip = Trip.find(params[:id])
    @trip.update(trip_params)
    authorize @trip
    redirect_to trips_path
  end

  def destroy
    @trip = Trip.find(params[:id])
    authorize @trip
    @trip.destroy
  end

  def auto_create

    @start_date = params[:start_date]
    @end_date = params[:end_date]
    @destination = params[:destination]
    @purpose = params[:purpose]
    @origin = params[:origin]
    @birth = params[:birth]

    @trip = Trip.create(name: "Testtrip", description: "Test Description", location: @destination)
    authorize @trip
    # This is the start of the magic

    redirect_to confirmation_path(@trip)
  end

  def confirmation
    @trip = Trip.find(params[:id])
    @trip.user = current_user
    @trip.save
    authorize @trip
  end

  private

  def trip_params
    params.require(:trip).permit(:location, :name, :description, :photo )
  end

  def auto_trip_params
    params.require(:trip).permit(:start_date, :end_date, :gender, :age, :origin, :purpose, :location)
  end
end
