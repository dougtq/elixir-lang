defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller

  alias DiscussWeb.Topic
  alias Discuss.Repo

  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index(conn, _params) do
    render conn, "index.html", topics: Repo.all(Topic)
  end

  @spec new(Plug.Conn.t(), any) :: Plug.Conn.t()
  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{})

    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{ "topic" => topic }) do
    IO.inspect conn
    IO.inspect "____________________________________________________"
    IO.inspect topic
    IO.inspect "____________________________________________________"

    changeset = Topic.changeset(%Topic{}, topic)

    case Repo.insert(changeset) do
      {:ok, topic} ->
        IO.inspect topic

        conn
        |> put_flash(:info, "Topic created successfully")
        |> redirect(to: Routes.topic_path(conn, :index))
      {:error, changeset} ->
        IO.inspect changeset
        render conn, "new.html", changeset: changeset


    end
  end

  @spec edit(Plug.Conn.t(), map) :: Plug.Conn.t()
  def edit(conn, %{ "id" => id }) do
    topic = Repo.get(Topic, id)

    changeset = Topic.changeset(topic)

    # case Repo.get(Topic, id) do
    #   { :ok, topic } ->
    #     render conn, "edit.html", topic: topic
    #   { :error, _ } ->
    #     conn
    #     |> put_flash(:error, "Failed to get topic")
    # end

    render conn, "edit.html", topic: topic, changeset: changeset
  end

  @spec update(Plug.Conn.t(), map) :: Plug.Conn.t()
  def update(conn, %{ "id" => id, "topic" => topic }) do
    old_topic = Topic |> Repo.get!(id)
    changeset = Topic.changeset(old_topic, topic)

    case Repo.update(changeset) do
      { :ok, _topic } ->
        conn
        |> put_flash(:info, "Topic updated successfully")
        |> redirect(to: Routes.topic_path(conn, :index))
      { :error, changeset } ->
        conn
        |> render("edit.html", changeset: changeset, topic: old_topic)
    end
  end

  @spec delete(Plug.Conn.t(), map) :: Plug.Conn.t()
  def delete(conn, %{ "id" => id }) do
    Topic |> Repo.get!(id) |> Repo.delete!

    conn
    |> put_flash(:info, "Topic deleted successfully")
    |> redirect(to: Routes.topic_path(conn, :index))
  end
end
