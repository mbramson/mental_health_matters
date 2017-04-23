defmodule MentalHealthMatters.Account do
  @moduledoc """
  The boundary for the Account system.
  """

  import Ecto.{Query, Changeset}, warn: false
  alias MentalHealthMatters.Repo

  alias MentalHealthMatters.Account.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> user_create_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> user_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def login_user(attrs) do
    result = with {:ok, email} <- Map.fetch(attrs, "email"),
                  {:ok, password} <- Map.fetch(attrs, "password"),
                  %User{} = user <- Repo.get_by(User, %{email: email}) do
      validate_password(password, user)
    end
    case result do
      {:ok, user} -> {:ok, user}
      _ -> {:error, user_changeset(%User{}, %{})}
    end
  end

  defp validate_password(password, user) do
    if Comeonin.Bcrypt.checkpw(password, user.password_hash) do
      {:ok, user}
    else
      {:error, :invalid_password}
    end
  end 

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    user_changeset(user, %{})
  end

  @changeset_attrs [:name, :email, :student_id, :is_client, :is_coach, :is_manager]
  @required_attrs [:name, :email]

  defp user_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, @changeset_attrs)
    |> validate_required(@required_attrs)
    |> unique_constraint(:email)
  end

  @changeset_create_attrs [:name, :email, :student_id, :password, :is_client, :is_coach, :is_manager]
  @required_create_attrs [:name, :email, :password]

  defp user_create_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, @changeset_create_attrs)
    |> validate_required(@required_create_attrs)
    |> unique_constraint(:email)
    |> hash_password_if_changed_and_valid
  end

  # Hashes the contents of the :password field and inserts the results into the
  # :password_hash field. Only hashes and inserts if the password was changed
  # and the changeset is valid.
  @spec hash_password_if_changed_and_valid(%Ecto.Changeset{}) :: %Ecto.Changeset{}
  defp hash_password_if_changed_and_valid(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end

end
