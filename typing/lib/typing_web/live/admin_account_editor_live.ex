defmodule TypingWeb.AdminAccountEditorLive do
  use Phoenix.LiveView
  alias Typing.Editor.AdminAccountEditor
  alias Typing.Admin

  def render(assigns), do: TypingWeb.AdminAccountEditorView.render(assigns.template, assigns)

  def mount(_params, session, socket) do
    account = Admin.get_account(session["admin_account_id"])

    socket =
      socket
      |> assign(:editor, AdminAccountEditor.construct(account))
      |> assign(:page_title, "アカウント情報")
      |> assign(:template, "main.html")

    {:ok, socket}
  end
end
