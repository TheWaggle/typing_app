defmodule TypingWeb.AdminAccountAuth do
  import Plug.Conn
  import Phoenix.Controller

  alias TypingWeb.Router.Helpers, as: Routes
  alias Typing.Admin

  @doc """
  セッションを調べてアカウント認証をします。
  認証できない場合はnilを返します。
  """
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

  @doc """
  認証した場合にリダイレクトします。
  """
  def redirect_if_admin_account_is_authenticated(conn, _otps) do
    if conn.assigns[:current_admin_account] do
      conn
      |> redirect(to: "/")
      |> halt()
    else
      conn
    end
  end

  @doc """
  認証が必要なルートに使用します。
  認証ができない場合はログイン画面にリダイレクトします。
  """
  def require_authenticated_admin_account(conn, _opts) do
    if conn.assigns[:current_admin_account] do
      conn
    else
      conn
      |> maybe_store_return_to()
      |> redirect(to: "/admin/log_in")
      |> halt()
    end
  end

  defp maybe_store_return_to(%{method: "GET"} = conn) do
    put_session(conn, :account_return_to, current_path(conn))
  end

  defp maybe_store_return_to(conn), do: conn
end
