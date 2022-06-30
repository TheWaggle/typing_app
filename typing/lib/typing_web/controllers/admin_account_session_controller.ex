defmodule TypingWeb.AdminAccountSessionController do
  use TypingWeb, :controller

  import Plug.Conn
  alias Typing.Admin

  def new(conn, _params) do
    render(conn, "new.html", account: Admin.Account.build_changeset(), message: nil)
  end

  def create(conn, params) do
    account_params = Map.get(params, "account", %{})
    name = Map.get(account_params, "name", "")
    password = Map.get(account_params, "password", "")

    case Admin.get_account_by_password(name, password) do
      %Admin.Account{} = account ->
        token = Admin.generate_account_session_token(account)

        conn
        |> configure_session(renew: true)
        |> clear_session()
        |> put_session(:admin_account_token, token)
        |> put_session(:admin_account_id, account.id)
        |> redirect(to: Routes.admin_account_editor_path(conn, :index))

      nil ->
        render(conn, "new.html", account: Admin.Account.build_changeset(), message: "アカウント名またはパスワードが違います。")
    end
  end

  def delete(conn, _params) do
    token = get_session(conn, :admin_account_token)
    Admin.delete_session_token(token)

    conn
    |> delete_session(:admin_account_token)
    |> delete_session(:admin_account_id)
    |> redirect(to: "/admin/log_in")
  end
end
