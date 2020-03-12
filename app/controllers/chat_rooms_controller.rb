class ChatRoomsController < ApplicationController
  def show
    @chat_room = ChatRoom.includes(messages: :user).find(params[:id])
    authorize @chat_room
  end

  def create
    @trip = Trip.find(params[:trip_id])
    @arrival_destination = @trip.location.split(', ')[-1].downcase.capitalize!

    @chat_room = ChatRoom.find_or_create_by(name: @arrival_destination)
    authorize @chat_room
    @trip.chat_room_id = @chat_room.id


    if @trip.save!
      respond_to do |format|
        format.html { redirect_to chat_room_path(@chat_room) }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to trip_path(@trip) }
        format.js
      end
    end
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:name)
  end
end
