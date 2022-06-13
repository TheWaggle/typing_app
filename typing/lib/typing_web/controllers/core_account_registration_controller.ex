defmodule TypingWeb.CoreAccountRegistrationController do
  use TypingWeb, :controller

  import Plug.Conn
  alias Typing.Core

  def new(conn, _params) do
    render(conn, "new.html", account: Core.Account.build_changeset(), message: nil)
  end

  def create(conn, params) do
    account = Map.get(params, "account", %{})

    case Core.create_account(account) do
      {:error, cs} ->
        render(conn, "new.html", account: cs, message: "アカウントを作成できませんでした。")

      {:ok, %Core.Account{} = account} ->
        token = Core.generate_account_session_token(account)

        conn
        conn
        |> configure_session(renew: true)
        |> clear_session()
        |> put_session(:core_account_token, token)
        |> put_session(:core_account_id, account.id)
        |> redirect(to: Routes.game_editor_path(conn, :index))
    end
  end
end
