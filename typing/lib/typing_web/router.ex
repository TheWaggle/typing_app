defmodule TypingWeb.Router do
  use TypingWeb, :router

  import TypingWeb.CoreAccountAuth
  import TypingWeb.AdminAccountAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {TypingWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # 認証していない場合はこちらのルートを使用する
  scope "/", TypingWeb do
    pipe_through [:browser, :fetch_current_core_account, :redirect_if_core_account_is_authenticated]

    get "/", PageController, :index
    get "/log_in", CoreAccountSessionController, :new
    post "/log_in", CoreAccountSessionController, :create

    get "/join", CoreAccountRegistrationController, :new
    post "/join", CoreAccountRegistrationController, :create
  end

  # 認証している場合はこちらのルートを使用する
  scope "/", TypingWeb do
    pipe_through [:browser, :fetch_current_core_account, :require_authenticated_core_account]

    live_session :game do
      live "/game", GameEditorLive, :index
    end
  end

  scope "/", TypingWeb do
    pipe_through [:browser, :fetch_current_core_account]

    delete "/log_out", CoreAccountSessionController, :delete
  end

  # admin

  # 認証していない場合はこちらのルートを使用する
  scope "/admin", TypingWeb do
    pipe_through [:browser, :fetch_current_admin_account, :redirect_if_admin_account_is_authenticated]


    get "/log_in", AdminAccountSessionController, :new
    post "/log_in", AdminAccountSessionController, :create
  end

  #  認証している場合はこちらのルートを使用する
  scope "/admin", TypingWeb do
    pipe_through [:browser, :fetch_current_admin_account, :require_authenticated_admin_account]

    live_session :admin_account do
      live "/account", AdminAccountEditorLive, :index
    end
  end

  scope "/admin", TypingWeb do
    pipe_through [:browser, :fetch_current_admin_account]

    delete "/log_out", AdminAccountSessionController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", TypingWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: TypingWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
