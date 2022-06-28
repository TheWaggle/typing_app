defmodule TypingWeb.CoreAccountSessionController do
  use TypingWeb, :controller

  import Plug.Conn
  alias Typing.Core

  def new(conn, _params) do
    render(conn, "new.html", account: Core.Account.build_changeset(), message: nil)
  end

  def create(conn, params) do
    account_params = Map.get(params, "account", %{})
    name = Map.get(account_params, "name", "")
    password = Map.get(account_params, "password", "")

    case Core.get_account_by_password(name, password) do
      %Core.Account{} = account ->
        token = Core.generate_account_session_token(account)

        conn
        |> configure_session(renew: true)
        |> clear_session()
        |> put_session(:core_account_token, token)
        |> put_session(:core_account_id, account.id)
        |> redirect(to: Routes.game_editor_path(conn, :index))

      nil ->
        render(conn, "new.html", account: Core.Account.build_changeset(), message: "アカウント名またはパスワードが違います。")
    end
  end
end
