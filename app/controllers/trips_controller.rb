# require_relative 'create_trips/accomodation'
# require_relative 'create_trips/apps'
# require_relative 'create_trips/transportation'
# require_relative 'create_trips/packinglist'
# require_relative 'create_trips/visa'
# require_relative 'create_trips/vaccinations'
# require_relative 'create_trips/last_minute'
# require_relative 'create_trips/weatherdata'

class TripsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:auto_create, :confirmation]

  def show
    @trip = Trip.find(params[:id])
    authorize @trip

    @markers = [
      {
        lat: @trip.latitude,
        lng: @trip.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { trip: @trip })
      }
    ]
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
    # Calculate all available variables

    @start_date = params[:start_date].to_date
    @end_date = params[:end_date].to_date
    @trip_length = (@end_date - @start_date).to_i

    @destination = params[:destination]

    # @origin = params[:origin]

    # @purpose = params[:purpose]

    # @gender = params[:gender]

    # @birth = params[:birth].to_date
    # birthday = @birth.year
    # @age = Date.today.year - birthday
    # @age -= 1 if Date.today < birthday + @age.years


    # Create Trip
    @trip = Trip.new(name: "#{@destination} - #{@start_date.year}", description: "Planit suggests the following preparation steps for your trip. We hope it helps. Have a great trip!", location: @destination, start_date: @start_date, end_date: @end_date, gender: @gender, age: @age, origin: @origin, purpose: @purpose)
    @trip.user = current_user if user_signed_in?
    @trip.save
    authorize @trip

    # Get Weather
    @weather = get_weather
    @max_temp = @weather[(@start_date.month - 1)]["absMaxTemp"]

    # Create Tasks
    accomodation(@trip)
    apps(@trip)
    transportation(@trip)
    packinglist(@trip)
    visa(@trip)
    vaccinations(@trip)
    last_minute(@trip)

    # Redirect
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
