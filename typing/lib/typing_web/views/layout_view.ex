defmodule TypingWeb.LayoutView do
  use TypingWeb, :view
  import Plug.Conn

  # Phoenix LiveDashboard is available only in development by default,
  # so we instruct Elixir to not warn if the dashboard route is missing.
  @compile {:no_warn_undefined, {Routes, :live_dashboard_path, 2}}

  # core_account_tokenのセッションを取得する。
  def get_token(conn) do
    core_account = get_session(conn, :core_account_token)
    admin_account = get_session(conn, :admin_account_token)

    cond do
      core_account != nil -> core_account
      admin_account != nil -> admin_account
      true -> nil
    end
  end

  def get_path_info(conn) when length(conn.path_info) > 0 do
    hd(conn.path_info)
  end

  def get_path_info(_conn), do: ""
end
