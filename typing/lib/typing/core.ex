defmodule Typing.Core do
  import Ecto.Query, warn: false
  alias Typing.Repo
  alias Typing.Core

  @doc """
  idからcore_accountを取得します。
  存在しないidの場合はnilを返します。
  """
  @spec get_account(Ecto.UUID.t()) :: Core.Account.t() | nil
  def get_account(<<_::288>> = id) do
    query =
      from(a in Core.Account,
        where: a.id == ^id)

    Repo.one(query)
  end

  def get_account(_id), do: nil
end
