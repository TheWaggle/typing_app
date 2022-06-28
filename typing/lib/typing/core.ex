defmodule Typing.Core do
  import Ecto.Query, warn: false
  alias Typing.Repo
  alias Typing.Core

  @doc """
  idからcore_accountを取得します。
  """
  @spec get_account(Ecto.UUID.t()) :: Core.Account.t() | nil
  def get_account(<<_::288>> = id) do
    query =
      from(a in Core.Account,
        where: a.id == ^id
      )

    Repo.one(query)
  end

  def get_account(_id), do: nil

  @doc """
  アカウント名とパスワードでcore_accountを取得します。
  アカウント名またはパスワードがあっていない場合はnilを返します。
  """
  @spec get_account_by_password(String.t(), String.t()) :: Core.Account.t() | nil
  def get_account_by_password(name, password)
      when is_binary(name) and is_binary(password) do
    query =
      from(a in Core.Account,
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
  @spec generate_account_session_token(Core.Account.t()) :: binary()
  def generate_account_session_token(%Core.Account{} = account) do
    {token, account_token} = build_session_token(account)
    Repo.insert(account_token)
    token
  end

  @rand_size 32
  defp build_session_token(account) do
    token = :crypto.strong_rand_bytes(@rand_size)
    {token, %Core.AccountToken{token: token, context: "session", account_id: account.id}}
  end
end
