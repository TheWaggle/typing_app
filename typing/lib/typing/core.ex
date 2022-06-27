defmodule Typing.Core do
  import Ecto.Query, warn: false
  alias Typing.Repo
  alias Typing.Core

  @doc """
  idからcore_accountを取得します。
  """
  def get_account(<<_::288>> = id) do
    query =
      from(a in Core.Account,
        where: a.id == ^id)

    Repo.one(query)
  end

  def get_account(_id), do: nil
end
