import consumer from "./consumer"

const chatRoom = document.getElementById("chatroom");

if (chatRoom) {
  consumer.subscriptions.create({ channel: "ChatRoomsChannel", room: "Best Room", chat_room_id: chatRoom.dataset.id }, {
  received(data) {
    if (data["current_user_id"] != chatRoom.dataset.userId) {
      this.appendLine(data)
      scrollLastMessageIntoView();
    }
  },

  appendLine(data) {
    console.log(data)
    const element = document.querySelector(".messages")
    element.insertAdjacentHTML("beforeend", data["message_partial"])
  }
})
}

