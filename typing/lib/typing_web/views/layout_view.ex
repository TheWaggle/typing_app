defmodule TypingWeb.LayoutView do
  use TypingWeb, :view
  import Plug.Conn

  # Phoenix LiveDashboard is available only in development by default,
  # so we instruct Elixir to not warn if the dashboard route is missing.
  @compile {:no_warn_undefined, {Routes, :live_dashboard_path, 2}}

  # core_account_tokenのセッションを取得する。
  def get_token(conn) do
    get_session(conn, :core_account_token)
  end
end
