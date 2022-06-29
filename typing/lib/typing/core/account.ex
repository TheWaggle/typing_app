defmodule Typing.Core.Account do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Typing.Repo
  alias Typing.Core

  @type t :: %__MODULE__{
          id: Ecto.UUID.t(),
          name: String.t(),
          email: String.t(),
          hashed_password: String.t(),
          password: String.t(),
          inserted_at: DateTime.t(),
          updated_at: DateTime.t
  }

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "core_accounts" do
    field(:name, :string)
    field(:email, :string)
    field(:hashed_password, :string, redact: true)

    timestamps()

    field(:password, :string, virtual: true, redact: true)
  end

  def build_changeset(), do: cast(%__MODULE__{}, %{}, [])

  def changeset(account, attrs \\ %{}) do
    account
    |> cast(attrs, [:name, :email, :password])
    |> validate_email()
    |> validate_password()
  end

  defp validate_email(changeset) do
    changeset
    |> validate_required([:email])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "@記号を含める必要です。また、スペースは含めないでください。")
    |> validate_length(:email, max: 160)
    |> validate_unique_email()
  end

  defp validate_unique_email(changeset) do
    email = get_field(changeset, :email)

    query =
      from(a in Core.Account,
        select: a.email
      )

    emails = Repo.all(query)

    if Enum.member?(emails, email) == false do
      changeset
    else
      add_error(changeset, :email, "すでにこのメールアドレスは使用されています。")
    end
  end

  defp validate_password(changeset) do
    changeset
    |> validate_required([:password])
    |> validate_length(:password, min: 5, max: 72)
    |> hash_password()
  end

  defp hash_password(changeset) do
    password = if p = get_change(changeset, :password), do: p, else: ""

    changeset
    |> validate_length(:password, max: 72, count: :bytes)
    |> put_change(:hashed_password, Bcrypt.hash_pwd_salt(password))
    |> delete_change(:password)
  end
end
