defmodule Graphical.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Graphical.Accounts.User
  alias Graphical.Repo

  schema "users" do
    field :email, :string
    field :name, :string
    field :token, :string
    field :password, :string, virtual: true
    field :pwd_hash, :string
    has_many :posts, Graphical.Posts.Post

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
  end

  def update_changeset(user, params \\ %{}) do
    user
    |> cast(params, [:name, :email], [:password])
    |> validate_required([:name, :email])
    |> put_pass_hash()
  end

  def registration_changeset(user, params \\ %{}) do
    user
    |> cast(params, [:name, :email], [:password])
    |> validate_required([:name, :email, :password])
    |> put_pass_hash()
  end

  def store_token_changeset(user, params \\ %{}) do
    user
    |> cast(params, [:token])
    |> validate_required([:token])
    |> put_pass_hash()
  end

  def authenticate(params) do
    user = Repo.get_by(User, email: String.downcase(params.email))
    case check_pwd(user, params.password) do
      true -> { :ok, user }
      _ -> { :error, "Incorret login credentials" }
    end
  end

  defp check_pwd(user, password) do
    case user do
      nil -> false
      _ -> Comeonin.Bcrypt.checkpw(password, user.pwd_hash)
    end
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{ valid?: true, changes: %{ password: password }} ->
        put_change(changeset, :put_pass_hash, Comeonin.Bcrypt.hashpwsalt(password))
      _ -> changeset
    end
  end

end
