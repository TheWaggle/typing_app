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

  def handle_event("toggle_" <> event, params, socket) do
    socket =
      update(socket, :editor, fn editor ->
        AdminThemeEditor.update(editor, event, params)
      end)

    {:noreply, socket}
  end

  def handle_event("sync_" <> event, params, socket) do
    socket =
      update(socket, :editor, fn editor ->
        AdminThemeEditor.sync(editor, event, params)
      end)

    {:noreply, socket}
  end

  def handle_event("save_" <> event, params, socket) do
    socket =
      update(socket, :editor, fn editor ->
        AdminThemeEditor.save(editor, event, params)
      end)

    {:noreply, socket}
  end
end
