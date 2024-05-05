defmodule DiscussWeb.Plugs.SetUser do
  import Plug.Conn
  import Phoenix.Controller

  alias DiscussWeb.Repo
  alias DiscussWeb.User
  alias DiscussWeb.Router.Helpers

  def init(_params) do
  end

  def call(conn, _params) do
    user_id = conn |>
    get_session(:user_id)

    cond do
      user = user_id && repo.get(User, user_id) ->
      
      true -> 
    end

  end
end