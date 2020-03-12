class AddChatRoomToTrip < ActiveRecord::Migration[6.0]
  def change
    add_reference :trips, :chat_room, foreign_key: true
  end
end
