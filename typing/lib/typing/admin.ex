defmodule Typing.Admin do
  alias Typing.Repo
  import Ecto.Query
  alias Typing.Admin

  @doc """
  idでAdmin.Accountを取得します。
  """
  @spec get_account(Ecto.UUID.t()) :: Admin.Account.t() | nil
  def get_account(<<_::288>> = id) do
    query =
      from(a in Admin.Account,
        where: a.id == ^id
      )

    Repo.one(query)
  end

  def get_account(_id), do: nil

  @doc """
  カウント名とパスワードでadmin_accountを取得します。
  アカウント名またはパスワードが合っていない場合はnilを返します。
  """
  @spec get_account_by_password(String.t(), String.t()) :: Admin.Account.t() | nil
  def get_account_by_password(name, password)
      when is_binary(name) and is_binary(password) do
    query =
      from(a in Admin.Account,
        where: a.name == ^name
      )

    if account = Repo.one(query) do
      if Bcrypt.verify_pass(password, account.hashed_password), do: account, else: nil
    else
      nil
    end
  end

  def get_account_by_password(_name, _password), do: nil

  @doc """
  アカウントのトークを作成します。
  """
  def generate_account_session_token(%Admin.Account{} = account) do
    {token, account_token} = build_session_token(account)
    Repo.insert(account_token)
    token
  end

  @rand_size 32
  defp build_session_token(account) do
    token = :crypto.strong_rand_bytes(@rand_size)
    {token, %Admin.AccountToken{token: token, context: "session", account_id: account.id}}
  end

  @doc """
  アカウントのトークンを削除します。
  """
  @spec delete_session_token(binary()) :: {:ok, Admin.Account.t()}
  def delete_session_token(token) when is_binary(token) do
    query =
      from(at in Admin.AccountToken,
        where: at.token == ^token
      )

    Repo.one(query)
    |> Repo.delete()
  end
end
