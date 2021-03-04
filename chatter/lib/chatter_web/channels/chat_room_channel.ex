defmodule ChatterWeb.ChatRoomChannel do
  use ChatterWeb, :channel

  @impl true
  def join("chat_room:lobby", payload, socket) do
    if authorized?(payload) do
      send(self(), :after_join)
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (chat_room:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    spawn(fn -> save_msg(payload) end)
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  def handle_info(:after_join, socket) do
    Chatter.Message.get_msgs(5)
    |> Enum.each(fn msg -> push(socket, "shout",
      %{
        name: msg.name,
        message: msg.message,
      }) end)
    {:noreply, socket}
  end

  defp save_msg(msg) do
    Chatter.Message.changeset(%Chatter.Message{}, msg) |> Chatter.Repo.insert
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
