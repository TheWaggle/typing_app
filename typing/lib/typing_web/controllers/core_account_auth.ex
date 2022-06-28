defmodule TypingWeb.CoreAccountAuth do
  import Plug.Conn
  import Phoenix.Controller

  alias TypingWeb.Router.Helpers, as: Routes, warn: false
  alias Typing.Core

  @doc """
  セッションを調べてアカウントを取得します。
  """
  def fetch_current_core_account(conn, _opts) do
    account = fetch_account(conn)
    assign(conn, :current_core_account, account)
  end

  defp fetch_account(conn) do
    if account_id = get_session(conn, :core_account_id) do
      Core.get_account(account_id)
    else
      nil
    end
  end

  @doc """
  認証している場合はリダイレクトをします。
  """
  def redirect_if_core_account_is_authenticated(conn, _opts) do
    if conn.assigns[:current_coer_acount] do
      conn
      |> redirect(to: "/")
      |> halt()
    else
      conn
    end
  end

  @doc """
  認証が必要なルートに使用します。
  認証が確認できない場合はログイン画面にリダイレクトします。
  """
  # ここにログイン画面にリダイレクトするルートを記述
  def requrie_authenticated_core_account(conn, _opts) do
    if conn.assigns[:current_core_account] do
      conn
    else
      conn
      |> maybe_store_return_to()
      |> redirect(to: Routes.core_account_session_path(conn, :new))
      |> halt()
    end
  end

  defp maybe_store_return_to(%{method: "GET"} = conn) do
    put_session(conn, :account_return_to, current_path(conn))
  end

  defp maybe_store_return_to(conn), do: conn
end
