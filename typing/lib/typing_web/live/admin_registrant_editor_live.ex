defmodule TypingWeb.AdminRegistrantEditorLive do
  use Phoenix.LiveView
  alias Typing.Editor.AdminRegistrantEditor
  alias Typing.Admin

  def render(assigns), do: TypingWeb.AdminRegistrantEditorView.render(assigns.template, assigns)

  def mount(_params, session, socket) do
    account = Admin.get_account(session["admin_account_id"])

    socket =
      socket
      |> assign(:editor, AdminRegistrantEditor.construct(account))
      |> assign(:page_title, "登録者一覧")
      |> assign(:template, "main.html")

    {:ok, socket}
  end
end
