defmodule ManagementExampleWeb.PageController do
  use ManagementExampleWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
