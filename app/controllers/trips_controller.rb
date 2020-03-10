require_relative './create_trips/accommodation'
require_relative './create_trips/apps'
require_relative './create_trips/transportation'
require_relative './create_trips/packinglist'
require_relative './create_trips/visa'
require_relative './create_trips/vaccinations'
require_relative './create_trips/weatherdata'
require_relative './create_trips/last_minute'
require_relative './create_trips/money'

class TripsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:finished, :auto_create, :confirmation, :background_create, :loading]

  def show
    @trip = Trip.find(params[:id])
    @task = Task.new
    @subtask = Subtask.new
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
    @trip.session = false
    authorize @trip
  end

  def update
    @trip = Trip.find(params[:id])
    @trip.session = false
    @trip.update(trip_params)
    authorize @trip
    redirect_to trips_path
  end

  def destroy
    @trip = Trip.find(params[:id])
    authorize @trip
    @trip.destroy
    redirect_to trips_path
  end

  def loading
    @start_date = params[:start_date].to_date
    @end_date = params[:end_date].to_date
    @trip_length = (@end_date - @start_date).to_i
    @origin = params[:origin]
    @destination = params[:destination]
    @destination_short = @destination.split(', ')[0].downcase.capitalize!

    @trip = Trip.new(name: "#{@destination_short} - #{@start_date.year}", description: "You are traveling for #{@trip_length} to #{@destination}. Happy travels!", location: @destination, start_date: @start_date, end_date: @end_date, gender: @gender, age: @age, origin: @origin, purpose: @purpose)
    @trip.user = current_user if user_signed_in?
    @trip.save

    session[:temporary_trip] = @trip.id
    authorize @trip
  end

  def confirmation
    @trip = Trip.find(session[:temporary_trip])
    @trip.session = true unless user_signed_in?
    authorize @trip

    @start_date = @trip.start_date.to_date
    @end_date = @trip.end_date.to_date
    @trip_length = (@end_date - @start_date).to_i
    @origin = @trip.origin

    # Get Weather
    @weather = get_weather
    @weather = @weather[(@start_date.month - 1)]

    @max_temp_c = @weather["absMaxTemp"].to_i
    @max_temp_f = @weather["absMaxTemp_F"].to_i
    @min_temp_c = @weather["absMinTemp"].to_i
    @min_temp_f = @weather["absMinTemp_F"].to_i
    @rainfall = @weather["avgDailyRainfall"].to_i

    # @max_temp = get_weather

    accommodation(@trip)
    apps(@trip)
    transportation(@trip)
    # lonelyplanet(@trip)
    packinglist(@trip)
    visa(@trip)
    vaccinations(@trip)
    money(@trip)
    last_minute(@trip)

    render layout: false
  end

  private

  def trip_params
    params.require(:trip).permit(:location, :name, :description, :photo )
  end

  def auto_trip_params
    params.require(:trip).permit(:start_date, :end_date, :gender, :age, :origin, :purpose, :location)
  end
end
