defmodule TypingWeb.AdminThemeEditorLive do
  use Phoenix.LiveView
  alias Typing.Editor.AdminThemeEditor
  alias Typing.Admin

  def render(assigns), do: TypingWeb.AdminThemeEditorView.render(assigns.template, assigns)

  def mount(_params, session, socket) do
    account = Admin.get_account(session["admin_account_id"])

    socket =
      socket
      |> assign(:editor, AdminThemeEditor.construct(account))
      |> assign(:page_title, "お題一覧")
      |> assign(:template, "main.html")

    {:ok, socket}
  end
end
