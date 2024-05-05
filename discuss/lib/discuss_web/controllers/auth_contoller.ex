defmodule DiscussWeb.AuthController do
  use DiscussWeb, :controller
  plug Ueberauth

  alias Discuss.Repo
  alias DiscussWeb.User

  def callback(%{ assigns: %{ ueberauth_auth: auth } } = conn, %{"provider" => provider_name } = params) do
    IO.inspect params

    user_params = %{
      token: auth.credentials.token,
      email: auth.info.email,
      provider: provider_name
    }

    changeset = User.changeset(%User{}, user_params)

    sign_in(conn, changeset)
  end

  def failure(conn, params) do
    IO.puts "--------------------------"
    IO.inspect conn.assigns
    IO.puts "--------------------------"
    IO.inspect params
    IO.puts "--------------------------"
  end


  defp sign_in(conn, changeset) do
    case insert_or_update_user(changeset) do
      { :ok, user } ->
        conn
        |> put_flash(:info, "Welcome!")
        |> put_session(:user_id, user.id)
        |> redirect(to: Routes.topic_path(conn, :index))
      { :error, _reason } ->
        conn
        |> put_flash(:error, "Error signing in...")
        |> redirect(to: Routes.topic_path(conn, :index))
    end
  end

  defp insert_or_update_user(changeset) do
    case Repo.get_by(User, email: changeset.changes.email) do
      nil ->
        Repo.insert(changeset)
      user ->
        { :ok, user }
    end
  end
end
