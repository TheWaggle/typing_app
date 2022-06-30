defmodule TypingWeb.AdminAccountAuth do
  import Plug.Conn
  import Phoenix.Controller

  alias TypingWeb.Router.Helpers, as: Routes
  alias Typing.Admin

  def fetch_current_admin_account(conn, _opts) do
    account = fetch_account(conn)
    assign(conn, :current_admin_account, account)
  end

  defp fetch_account(conn) do
    if account_id = get_session(conn, :admin_account_id) do
      Admin.get_account(account_id)
    else
      nil
    end
  end

  def redirect_if_admin_account_is_authenticated(conn, _otps) do
    if conn.assigns[:current_admin_account] do
      conn
      |> redirect(to: Routes.admin_account_editor_path(conn, :index))
      |> halt()
    else
      conn
    end
  end

  def require_authenticated_admin_account(conn, _opts) do
    if conn.assigns[:current_admin_account] do
      conn
    else
      conn
      |> maybe_store_return_to()
      |> redirect(to: Routes.admin_account_session_path(conn, :new))
      |> halt()
    end
  end

  defp maybe_store_return_to(%{method: "GET"} = conn) do
    put_session(conn, :account_return_to, current_path(conn))
  end

  defp maybe_store_return_to(conn), do: conn
end
